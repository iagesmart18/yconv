class AudioConverter
  attr_accessor :content

  def initialize content
    @content = content
  end

  def process
    raise "Audio convert error: #{content.id}-#{content.url}-#{content.human_name}" unless content.source_filename
    return unless content.may_convert?
    content.convert
    movie = FFMPEG::Movie.new(content.source_filename)
    mp3 = movie.transcode mp3_filename, options do |progress|
      content.update progress: (progress * 100)
    end
    save_filename
    remove_source_mp3

    content.finish
    content.save!
  end

  def save_filename
    filename = mp3_filename
    raise "No Filename #{@cmd}" unless filename
    puts "filename: [#{filename}]"
    file = File.open mp3_filename
    attachment = content.attachments.find_or_create_by(format: '.mp3')
    attachment.file = file
    attachment.save!
  end

  def remove_source_mp3
    return File.delete mp3_filename if File.exist? mp3_filename
    raise "MP3 source file not exist: #{mp3_filename}"
  end

  def mp3_filename
    @mp3_filename ||= content.source_filename.gsub File.extname(content.source_filename), '.mp3'
  end

  def options
    { audio_codec: 'libmp3lame', custom: %w(-qscale:a 2) }
  end
end
