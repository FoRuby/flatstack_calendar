class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :start, :end, :color, :update_url, :edit_url

  def start
    object.start_date
  end

  def end
    object.end_date
  end

  def edit_url
    edit_event_path(object)
  end

  def update_url
    event_path(object, method: :patch)
  end
end
