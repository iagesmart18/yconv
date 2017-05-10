#require_relative 'youtube_dl.rb'; youtube = YoutubeDl.new
class YoutubeDl
  def initialize url='https://www.youtube.com/watch?v=a4LVgdGN_8g'
    @url = url
  end

  def perform
    path = File.join Rails.root, 'public', 'content', '%(id)s_%(title)s.%(ext)s'
    @cmd = "youtube-dl --newline --restrict-filenames -o '#{path}' #{@url}"
    puts @cmd
    IO.popen(@cmd) do |stdout|
      stdout.each do |line|
        parse_line line
      end
    end
    save_filename
  end

  def parse_line line
    if line =~ /download/
      parse_progress line
      parse_file_name line
    end
  end

  def content
    @content ||= begin
      params = Rack::Utils.parse_query URI(@url).query
      name = params['v']
      content = Content.find_or_create_by name: name
      content
    end
  end

  def parse_file_name line
    if line.include? Rails.root.to_s
      match = line.match /(#{Rails.root.to_s}[^ ]*)/
      @filename = match[1]
    end
  end

  def parse_progress line
    if line.match /([\d.]+)%/
      progress = line.match /([\d.]+)%/
      content.update! progress: progress[1].to_f
    end
  end

  def save_filename
    raise "No Filename #{@cmd}" unless @filename
    content.attachment = File.open @filename
    content.save!
  end
end
