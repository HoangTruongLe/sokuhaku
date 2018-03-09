class RoomsCrawler < Crawler
  def initialize
    super
  end

  def get_service(id)
    @id = id
    @page = @agent.get("#{AIRBNB_ROOM_URL}#{@id}")
    @contents = parse_content_data(@page)
    @api_key = api_key_guest(@page)
  end

  def get_type_service
    type_service = @page.search(".//a[@class='link-reset']")
    EasySettings.crawler.room.type_service.level.times do |variable|
      type_service = type_service.children
    end
    type_service.text
  end

  def get_price_service
    api_price_service
  end

  def get_name_service
    begin
      name_service = @contents['bootstrapData']['reduxData']['marketplacePdp']['listingInfo']['listing']['p3_summary_title']
    rescue Exception => e
      name_service = ""
    end
  end

  def get_img_service
    begin
      image_services = @contents['bootstrapData']['reduxData']['marketplacePdp']['listingInfo']['listing']['photos']
    rescue Exception => e
      image_services = []
    end
  end

  private
    def api_price_service
      # Not include params
      #_parent_request_uuid: '26426150-404d-48c7-9f15-b5aeda74a524'
      #_p3_impression_id: 'p3_1519962051_Mxmnx5LU1nf2vlsy'

      params = {
        force_boost_unc_priority_message_type: '', show_smart_promotion: 0, key: @api_key,
        guests: 1, listing_id: @id, _format: 'for_web_dateless', _interaction_type: 'pageload', _intents: 'p3_book_it',
        number_of_adults: 1, number_of_children: 0, number_of_infants: 0, currency: 'JPY', locale: 'en'
      }

      uri = URI(AIRBNB_COST_URL)
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
      begin
        @price_service = result['pdp_listing_booking_details'].first['p3_display_rate']['amount_formatted']
      rescue Exception => e
        @price_service = ""
      end
    end
end