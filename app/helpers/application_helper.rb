module ApplicationHelper
  def read_from_file name
    path = File.join Rails.root, 'html', "#{name}.html"
    IO.read(path)
  end
end
