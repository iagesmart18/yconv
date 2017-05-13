namespace :content do
  desc 'reset all content data'
  task reset: :environment do
    Content.destroy_all
    Sidekiq::RetrySet.new.clear
    contents_path = File.join Rails.root, 'public', 'content'
    FileUtils.rm_rf("#{contents_path}/.", secure: true)
  end

  desc 'cleanup content when it takes more space than specified'
  task cleanup: :environment do
    contents = Content.includes(:attachments).all
    size = 0
    max_content_size = ENV['max_content_size'].to_i
    puts "Max contnet size in bytes: #{max_content_size}"

    contents.each { |content| size += content.total_file_size }

    puts "Attachments size in bytes: #{size}"
    if size >= max_content_size

      puts "Attachments size more than specified"

      contents.each do |content|
        if size <= max_content_size
          break
        end
        content_size = content.total_file_size
        content.destroy
        size -= content_size
      end
    end
  end
end

