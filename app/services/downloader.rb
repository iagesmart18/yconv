class Downloader
  YOUTUBE = 'youtube'
  AVAILABLE = [ YOUTUBE ]
  attr_accessor :url

  def initialize url
    @url = url
  end

  def perform &block
    if valid?
      block.call content if block_given?
    end
  end

  def validate_url
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

  def validate_availability
    AVAILABLE.any? { |host| url.include? host }
  end

  def name
    @name ||= begin
      if youtube?
        hash = Rack::Utils.parse_query URI(url).query
        @name = hash['v']
      end
    end
  end

  def content
    @content ||= begin
      @content = Content.find_or_create_by name: name
      @content.update! url: url
    end
  end

  private

  def youtube?
    url.includes? YOUTUBE
  end
end
