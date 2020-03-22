class SimpleEventSerializer < ActiveModel::Serializer
  # SimpleEventSerializer.new(@event).to_json

  # # json all smple events
  # ActiveModel::Serializer::CollectionSerializer
  #   .new(SimpleEvent.all,
  #        each_serializer: SimpleEventSerializer,
  #        root: false)
  #   .to_json
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :color, :start, :type, :end, :path

  def start
    object.date
  end

  def end
    object.end_date
  end

  def type
    object.type
  end

  def path
    simple_event_path(object)
  end
end
