class HostRoomsChannel < ApplicationCable::Channel
  def subscribed
    @host = Host.find(params[:host])
    @room_crawler = RoomsCrawler.new
    @rooms_cache = JSON.load($redis.get('rooms_crawler')) || []
    stream_from "host_#{@host.id}_#{params[:uuid]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def crawler(data)
    @id = data['room_id']
    @room_crawler.get_service(@id)
    @rooms_cache.push(parse_data.as_json)
    $redis.set('rooms_crawler', @rooms_cache.to_json)

    ActionCable.server.broadcast("host_#{@host.id}_#{params[:uuid]}", data: { type: 'crawler', record: render_room })
  end

  private

  def render_room
    ApplicationController.render(
      partial: 'admins/hosts/room',
      locals: parse_data
    )
  end

  def parse_data
    {
      id_service: @id,
      id_host: @host.id,
      name_service: @room_crawler.get_name_service,
      type_service: @room_crawler.get_type_service,
      img_service: @room_crawler.get_img_service,
      price_service: @room_crawler.get_price_service
    }
  end
end
