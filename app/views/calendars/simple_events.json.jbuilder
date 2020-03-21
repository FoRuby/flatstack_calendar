json.array! @simple_events do |event|
  json.id event.id
  json.title event.title
  json.description event.description
  json.start event.date
  json.end event.end_date
  json.color event.color
  
  json.path simple_event_path(event)
end