class ContentDownloader
  include Sidekiq::Worker
  sidekiq_options unique: :until_and_while_executing

  def perform content_id
    content = Content.find content_id
    processor = DownloadProcessor.new content
    processor.perform
  end
end
