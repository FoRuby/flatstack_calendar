# Наследуется от Event
# Должно присутствовать поле recurrence в котором хранится сериализованное в хеш
#  правило повторений события

class RecurringEvent < Event
  attr_accessor :schedule_type

  serialize :recurrence, Montrose::Recurrence

  validates :start_date, :end_date, presence: true
  validate :validate_end_date_should_be_greater_then_start_date

  before_save :set_recurrence

  def dates
    recurrence.starting(start_date).until(end_date).events.map(&:to_date)
  end

  def next_date(date)
    day = date.to_date
    return nil unless dates.include? day

    dates[dates.find_index(day.to_date) + 1]
  end

  private

  def set_recurrence
    return if schedule_type.nil?

    self.recurrence = RecurringEventHelper.create_recurrence(schedule_type)
  end

  def validate_end_date_should_be_greater_then_start_date
    return if start_date.nil? || end_date.nil?
    return if start_date < end_date

    errors.add(:start_date, 'should be less then end date')
    errors.add(:end_date, 'should be greater then start date')
  end
end
