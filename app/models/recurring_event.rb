# Наследуется от Event
# Должно присутствовать поле schedule в котором хранится сериализованное в хеш
#  правило повторений события

class RecurringEvent < Event
  serialize :schedule

  validates :schedule, presence: true

  validate :validate_event_date_should_be_in_recurring_range

  def dates
    IceCube::Schedule.from_hash(schedule)
                     .occurrences((recurring_end_date + 1).to_time)
                     .map(&:to_date)
  end

  private

  def validate_event_date_should_be_in_recurring_range
    return if date&.between?(recurring_start_date, recurring_end_date)

    errors.add(:date, 'should be in recurring range')
  end
end
