recurring_range = recurring_event.dates
json.array! recurring_range do |recurring_date|
  json.id recurring_event.id
  json.title recurring_event.title
  json.description recurring_event.description
  json.color recurring_event.color
  json.start recurring_date
  json.end recurring_date + 1

  json.path recurring_event_path(recurring_event)
end
