class HomeController < ApplicationController
  def index
  end

  def convert
    url = params[:url]
    hash = Rack::Utils.parse_query URI(url).query
    name = hash['v']
    content = Content.find_or_create_by name: name
    content.update! url: url
    Downloader.perform_async content.id
    render json: { content_id: content.id }
  end
end
