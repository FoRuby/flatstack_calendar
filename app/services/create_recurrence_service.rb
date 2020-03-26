module CreateRecurrenceService
  SCHEDULE_TYPES = %w[day week month year]

  # Из входных данных создает правило повторений
  # TODO: допилить полноценный функционал
  def self.call(schedule_type)
    Montrose.every(schedule_type.to_sym)
  end
end
