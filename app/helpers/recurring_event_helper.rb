module RecurringEventHelper
  def self.to_json(recurring_event)
    ActiveModel::Serializer::CollectionSerializer
      .new(
        recurring_event.events,
        each_serializer: RecurringEventSerializer,
        root: false
      ).to_json
  end

  def next_date(next_date)
    return 'not determined' if next_date.nil?

    next_date.to_formatted_s(:rfc822).to_s
  end
end
