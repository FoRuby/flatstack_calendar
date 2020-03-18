# Наследуется от Event
# Должно присутствовать поле schedule в котором хранится сериализованное в хеш
#  правило повторений события

class RecurringEvent < Event
  SCHEDULE = %w[day week month year]

  validates :schedule, :start_date, :end_date, presence: true
  validates :schedule, inclusion: { in: SCHEDULE }

  validate :validate_end_date_should_be_greater_then_start_date

  # def dates
  #   IceCube::Schedule.from_hash(schedule)
  #                    .occurrences((recurring_end_date + 1).to_time)
  #                    .map(&:to_date)
  # end

  private

  def validate_end_date_should_be_greater_then_start_date
    return if start_date < end_date

    errors.add(:start_date, 'should be less then end date')
    errors.add(:end_date, 'should be greater then start date')
  end
end
