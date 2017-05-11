class Converter
  include Sidekiq::Worker

  def perform content_id
    content = Content.find content_id
    return unless content.may_convert?
    content.convert
    content.finish
    content.save!
  end
end
