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
      val = nil
      if youtube?
        hash = Rack::Utils.parse_query URI(url).query
        val = "youtube_#{hash['v']}"
      end

      if vimeo?
        val = "vimeo_#{URI(url).path[1..-1]}"
      end
      val
    end
  end

  def content
    @content ||= begin
      @content = Content.find_by_name name

      if @content && @content.error_msg
        @content.destroy
        @content = nil
      end

      unless @content
        @content = Content.create! name: name, url: url
      end
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
