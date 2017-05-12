class DownloadProcessor
  attr_accessor :content
  def initialize content
    @content = content
    @filenames = []
  end

  def perform
    return unless content.may_download?
    content.download
    execute do |line|
      parse_line line
    end
    save_filename
    Converter.perform_async content.id
  rescue Exception => e
    content.error_msg = "Due downloading occur error for url #{content.url}"
    content.rollback
    content.save!
    raise
  end

  def execute &block
    path = File.join Rails.root, 'public', 'content', '%(id)s_%(title)s.%(ext)s'
    @cmd = "#{ENV['command']} --newline --restrict-filenames -f 'bestvideo[ext=mp4]' -o '#{path}' #{content.url}"
    puts @cmd
    IO.popen(@cmd) do |stdout|
      stdout.each do |line|
        block.call line if block_given?
      end
    end
  end

  def parse_line line
    # if line =~ /download/
      parse_progress line
      parse_file_name line
    # end
  end

  def parse_file_name line
    if line.include? Rails.root.to_s
      puts "[ #{line} ]"
      match = line.match /(#{Regexp.escape(Rails.root.to_s)}[^ "]*)/
      @filenames << match[1].strip
    end
  end

  def parse_progress line
    if line.match /([\d.]+)%/
      progress = line.match /([\d.]+)%/
      content.update! progress: progress[1].to_f
    end
  end

  def save_filename
    filename = fetch_valid_filename
    raise "No Filename #{@cmd}" unless filename
    puts "filename: [#{filename}]"
    ext = File.extname filename
    content.source_filename = filename
    attachment = content.attachments.find_or_create_by(format: ext)
    attachment.file = File.open filename
    attachment.save!
    content.save!
  end

  def fetch_valid_filename
    @filenames = @filenames.uniq
    @filenames.find { |filename| File.exist? filename }
  end
end
