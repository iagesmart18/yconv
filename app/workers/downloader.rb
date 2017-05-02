class Downloader
  include Sidekiq::Worker

  def perform video_url
  end
end
