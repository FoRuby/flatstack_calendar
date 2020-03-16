recurring_range = recurring_event.dates
json.array! recurring_range do |recurring_date|
  json.id "recurring_#{recurring_event.id}"
  json.title recurring_event.title
  json.description recurring_event.description
  json.start recurring_date
  json.end recurring_date
  json.color recurring_event.color
end
