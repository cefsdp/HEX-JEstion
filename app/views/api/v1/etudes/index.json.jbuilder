# app/views/api/v1/etudes/index.json.jbuilder
json.array! @etudes do |etude|
  json.extract! etude, :id, :reference
end
