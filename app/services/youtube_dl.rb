#require_relative 'youtube_dl.rb'; youtube = YoutubeDl.new
class YoutubeDl
  def initialize url
    @url = url
  end

  def perform url='https://www.youtube.com/watch?v=a4LVgdGN_8g'
    IO.popen("youtube-dl --newline #{url}") do |stdout|
      stdout.each do |line|
        parse_line line
      end
    end
    puts "this #{counter}"
  end

  def parse_line line
    if line =~ /download/
      progress = line.match /([\d.]+)%/
      content.update! progress: progress[1].to_f
    end

    if line =~ /Destination/
      human_name = line.match /Destination: (.*)/
      content.update! human_name: human_name[1]
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
end
