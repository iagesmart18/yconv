class Converter
  include Sidekiq::Worker
  sidekiq_options unique: :until_and_while_executing

  def perform content_id
    content = Content.find content_id
    converter = AudioConverter.new content
    converter.process
  end
end
