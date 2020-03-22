module RecurringEventHelper
  SCHEDULE_TYPES = %w[day week month year]

  # Из входных данных создает правило повторений
  # TODO: допилить полноценный функционал и вынести
  def self.create_recurrence(schedule_type)
    Montrose.every(schedule_type.to_sym)
  end

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
