class ContentDownloader
  include Sidekiq::Worker

  def perform content_id
    content = Content.find content_id
    processor = DownloadProcessor.new content
    processor.perform
  end
end
