# frozen_string_literal: true
class Admins::HostsController < ApplicationController
  before_action :init_service, only: [:rooms_list]
  before_action :find_host, only: [:rooms_list]
  before_action :find_rooms, only: [:rooms_list]
  before_action :authenticate_admin!
  layout 'devise'

  def rooms_list
    if @host.try(:rooms).present?
      room_ids = @host.try(:rooms).pluck(:service_id)
      @rooms_cache.each do |r|
        if room_ids.include? r['id_service']
          @rooms << r
          @rooms_cache_ids << r['id_service']
        end
      end
      @uuid = SecureRandom.uuid
      @room_crawler = room_ids - @rooms_cache_ids
    end
  end

  def index
    @hosts = Host.all.page(params[:page]).includes(:rooms).per(EasySettings.paging.per)
  end

  private
    def find_host
      @host = Host.find_by_id(params[:id])
      # @host = nil
      # return false unless @host.present?
    end

    def init_service
      @rooms = []
      @rooms_cache_ids = []
    end

    def find_rooms
      @rooms_cache = []
      redis_rooms_cache = JSON.load($redis.get('rooms_crawler')) || []
      redis_rooms_cache.each {|r| @rooms_cache << r if r['id_host'] ==  @host.try(:id) }
      @rooms_cache
    end

end
