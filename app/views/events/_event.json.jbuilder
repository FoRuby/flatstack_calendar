json.id event.id
json.title event.title
json.description event.description
json.start event.start_date
json.end event.end_date
json.color event.color
json.update_url event_path(event, method: :patch)
json.edit_url edit_event_path(event)
