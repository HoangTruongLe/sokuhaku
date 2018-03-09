class HomesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "homes_#{params['visitor_uuid']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def airbnb_crawler(data)
    visitor_uuid = data['visitor_uuid']
    params = build_params(data)
    AirbnbHomesCrawlerJob.perform_now(visitor_uuid, params)
  end

  private 
  def build_params(data)
    params = {}
    params.merge!({adults: data['adults']}) if data['adults']
    params.merge!({children: data['children']}) if data['children']
    params.merge!({price_max: data['infants']}) if data['infants']
    params.merge!({price_max: data['price_min']}) if data['price_min']
    params.merge!({price_max: data['price_max']}) if data['price_max']
    params.merge!({'room_types[]': data['room_types']}) if data['room_types']
    params.merge!({min_beds: data['min_beds']}) if data['min_beds']
    params.merge!({min_bedrooms: data['min_bedrooms']}) if data['min_bedrooms']
    params.merge!({min_bathrooms: data['min_bathrooms']}) if data['min_bathrooms']
    params.merge!({query: data['query']}) if data['query']
    params
  end
end