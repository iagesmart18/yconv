namespace :content do
  desc 'reset all content data'
  task reset: :environment do
    Content.destroy_all
    Sidekiq::RetrySet.new.clear
    contents_path = File.join Rails.root, 'public', 'content'
    FileUtils.rm_rf("#{contents_path}/.", secure: true)
  end
end

