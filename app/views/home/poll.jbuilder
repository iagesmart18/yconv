json.contents do |json|
  json.array! @contents do |content|
    json.id content.id
    json.url content.url
    json.name content.name
    json.state content.status
    json.progress content.progress
  end
end

json.poll_template  render_to_string partial: 'contents', locals: { contents: @contents }

json.need_continue true
json.errors @contents.select { |content| !content.error_msg.blank? }
                     .map { |content| content.error_msg }

if @contents.all? { |item| item.processed? }
  json.need_continue false
end

