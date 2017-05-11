class DownloadProcessor
  attr_accessor :content
  def initialize content
    @content = content
  end

  def perform
    content.download
    path = File.join Rails.root, 'public', 'content', '%(id)s_%(title)s.%(ext)s'
    @cmd = "youtube-dl --newline --restrict-filenames -o '#{path}' #{@content.url}"
    puts @cmd
    IO.popen(@cmd) do |stdout|
      stdout.each do |line|
        parse_line line
      end
    end
    save_filename
    content.save!
    Converter.perform_async content.id
  end

  def parse_line line
    if line =~ /download/
      parse_progress line
      parse_file_name line
    end
  end

  def parse_file_name line
    if line.include? Rails.root.to_s
      match = line.match /(#{Rails.root.to_s}[^ ]*)/
      @filename = match[1].strip
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
    puts "filename: [#{@filename}]"
    ext = File.extname @filename
    attachment = content.attachments.find_or_create_by(format: ext)
    attachment.file = File.open @filename
    attachment.save!
  end
end
