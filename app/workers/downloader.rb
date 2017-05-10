class Downloader
  include Sidekiq::Worker

  def perform content_id
    content = Content.find content_id
    youtube = YoutubeDl.new content
    youtube.perform
  end
end
