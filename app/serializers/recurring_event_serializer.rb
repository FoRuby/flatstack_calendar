class RecurringEventSerializer < ActiveModel::Serializer
  # # json single recurring event
  # ActiveModel::Serializer::CollectionSerializer
  #   .new(@recurring_event.last.events,
  #        each_serializer: RecurringEventSerializer,
  #        root: false)
  #   .to_json

  # # json all recurring events
  # ActiveModel::Serializer::CollectionSerializer
  #   .new(RecurringEvent.all.map(&:events),
  #        each_serializer: RecurringEventSerializer,
  #        root: false)
  #   .to_json

  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :color, :start, :end, :type, :path

  def start
    object.start_date
  end

  def end
    object.end_date
  end

  def type
    object.type
  end

  def path
    recurring_event_path(object)
  end
end
