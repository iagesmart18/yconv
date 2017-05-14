class Converter
  include Sidekiq::Worker

  def perform content_id
    content = Content.find content_id
    converter = AudioConverter.new content
    converter.process
  end
end
