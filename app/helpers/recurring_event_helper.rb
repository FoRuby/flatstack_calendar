module RecurringEventHelper
  SCHEDULE_TYPES = %w[day week month year]

  # Из входных данных создает правило повторений
  # TODO: допилить полноценный функционал
  def create_recurrance(schedule_type:, start_date:, end_date:)
    Montrose.every(schedule_type.to_sym, starts: start_date, until: end_date + 1)
  end
end
