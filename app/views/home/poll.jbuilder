json.array! @contents do |content|
  json.id content.id
  json.url content.url
  json.name content.name
  json.state content.status
  json.progress content.progress
end
