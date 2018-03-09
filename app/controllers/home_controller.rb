class HomeController < ApplicationController
  layout 'sokuhaku'

  def index
    @visitor_uuid = SecureRandom.uuid
  end
  
end
