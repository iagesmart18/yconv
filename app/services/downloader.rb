class Downloader
  include ActiveModel::Validations

  AVAILABLE = [ Content::YOUTUBE, Content::VIMEO ]
  attr_accessor :url, :response
  validate :validate_url, :validate_availability, :validate_name

  def initialize url
    @url = url
  end

  def perform &block
    if valid?
        block.call content if block_given?
      @response = { content_id: content.id }
    else
      @response = { errors: errors.full_messages.join(',') }
    end
  end

  def validate_url
    unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
      errors.add :base, "It's not looks like valid url: #{url}"
    end
  end

  def validate_availability
    unless AVAILABLE.any? { |host| url.include? host }
      errors.add :base, "Only these hosts supported: #{AVAILABLE.join(', ')}"
    end
  end

  def validate_name
    if name.blank?
      errors.add :base, "Can't get valid name from url"
    end
  end

  def name
    @name ||= begin
      if youtube?
        hash = Rack::Utils.parse_query URI(url).query
        @name = "youtube_#{hash['v']}"
      end

      if vimeo?
        @name = "vimeo_#{URI(url).path[1..-1]}"
      end
    end
  end

  def content
    @content ||= begin
      @content = Content.find_or_create_by name: name
      @content.update! url: url
      @content
    end
  end

  private

  def youtube?
    url.include? Content::YOUTUBE
  end

  def vimeo?
    url.include? Content::VIMEO
  end
end
