class HomeController < ApplicationController
  def index
  end

  def convert
    downloader = Downloader.new params[:url]
    downloader.perform do |content|
      ContentDownloader.perform_async content.id
    end

    render json: downloader.response
  end

  def remove
    content = Content.find params[:id]
    content.destroy
  end

  def poll
    @contents = Content.where id: params[:ids]
  end
end
