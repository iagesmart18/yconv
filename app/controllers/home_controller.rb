class HomeController < ApplicationController
  def index
  end

  def convert
    downloader = Downloader.new params[:url]
    downloader.perform do |content|
      ContentDownloader.perform_async content.id
    end

    render json: downloader.msg
  end
end
