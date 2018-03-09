class AirbnbHomesCrawlerJob < ApplicationJob
  queue_as :default

  def perform(visitor_uuid, params = {})
    crawler = AirbnbHomesCrawler.new
    homes = crawler.get_homes(params)
    ActionCable.server.broadcast "homes_#{visitor_uuid}_channel",
                                 homes: render_search_results(homes)
  end

  private

  def render_search_results(results)
    HomeController.render partial: 'home/index/article', locals: { homes: results }
  end
end