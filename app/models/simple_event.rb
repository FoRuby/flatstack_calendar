class SimpleEvent < Event
  belongs_to :user

  validates :date, :duration, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

  def end_date
    date + duration
  end
end
