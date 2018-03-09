class AirbnbHomesCrawler < Crawler
  AIRBNB_HOME = Crawler::AIRBNB_URL + 's/homes?refinement_paths[]=/homes&allow_override[]='

  AIRBNB_EXPLORE_API = Crawler::AIRBNB_URL + 'api/v2/explore_tabs'

  def initialize
    super
  end

  def get_homes(params = {})
    # checkin time is today
    checkin = Time.zone.now.strftime(EasySettings.datetime.date_format)
    
    # build conditions and redis_key
    params, redis_key = build_conditions(params, checkin, 'JPY', 'ja')
    # check data on redis and return when existed
    @homes = JSON.load($redis.get(redis_key)) || []
    return @homes unless @homes.blank?
    # execute crawl
    @page = @agent.get("#{AIRBNB_HOME}&checkin=#{checkin}")
    # get all data via api & get search results
    homes_details = homes_detail(params, api_key_guest(@page))
    @homes = explore_homes_details(homes_details)
    # save data to redis
    $redis.set(redis_key, @homes.to_json, ex: EasySettings.redis.top.expire_time.minutes)
    return @homes
  end

  def homes_detail(params, key)
    params.merge!({ 'key': key })
    return get_data_api(AIRBNB_EXPLORE_API, params)
  end

  def explore_homes_details(homes_details)
    homes = []
    homes_details['explore_tabs']&.first['sections'].each do |section|
      next if section['title'] && section['title'].downcase.include?('airbnb plus')
      next if section['listings'].blank?
      section['listings'].each do |data|
        item = data['listing']
        homes <<  { "service_id" => item['id'],
                    "lat"        => item['lat'],
                    "lng"        => item['lng'],
                    "name"       => item['name'],
                    "url"        => "#{Crawler::AIRBNB_ROOM_URL}#{item['id']}",
                    "spec"       => "#{item['space_type']}　#{item['city']}",
                    "pictures"   => item['picture_urls'],
                    "price"      => data['pricing_quote']['price']['total']['amount'],
                    "currency"   => data['pricing_quote']['price']['total']['currency']
                  }
      end
    end
    homes
  end

  private 

  def build_conditions(params, checkin, currency, locale)
    params = ({
      'version': '1.3.4',
      '_format': 'for_explore_search_web',
      'experiences_per_grid': '20',
      'items_per_grid': '18',
      'guidebooks_per_grid': '20',
      'auto_ib': true,
      'fetch_filters': true,
      'has_zero_guest_treatment': false,
      'is_guided_search': true,
      'is_new_cards_experiment': true,
      'luxury_pre_launch': false,
      'query_understanding_enabled': true,
      'show_groupings': true,
      'supports_for_you_v3': true,
      'timezone_offset': '420',
      'metadata_only': false,
      'is_standard_search': true,
      'tab_id': 'home_tab',
      '_intents': 'p1',
      'refinement_paths[]': '/homes',
      'allow_override[]': '',
      'checkin': checkin,
      'currency': currency,
      'locale': locale
    }).merge(params)
    redis_key = params.map{|k,v| "#{k}=#{v}"}.join('_')
    return params, redis_key
  end

end
