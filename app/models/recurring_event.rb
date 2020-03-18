# Наследуется от Event
# Должно присутствовать поле recurrence в котором хранится сериализованное в хеш
#  правило повторений события

class RecurringEvent < Event
  serialize :recurrence, Montrose::Recurrence

  validates :recurrence, :start_date, :end_date, presence: true

  validate :validate_end_date_should_be_greater_then_start_date

  def dates
    recurrence.map(&:to_date)
  end

  private

  def validate_end_date_should_be_greater_then_start_date
    return if start_date < end_date

    errors.add(:start_date, 'should be less then end date')
    errors.add(:end_date, 'should be greater then start date')
  end
end
