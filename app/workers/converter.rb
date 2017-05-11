class Converter
  include Sidekiq::Worker

  def perform content_id
    content = Content.find content_id
    content.convert
    content.finish
    content.save!
  end
end
