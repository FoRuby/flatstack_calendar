class Event < ApplicationRecord
  COLOR_REGEX = /\A#[0-9a-f]{3,6}\z/i
  EVENT_TYPES = %w[private public]
  DATE_FORMAT = '%M:%H %d %B %Y'

  scope :public_events, -> { where(event_type: 'public') }

  validates :title, :start_date, :end_date, :event_type, :color, presence: true
  validates :color, format: { with: COLOR_REGEX }
  validates :event_type, inclusion: { in: EVENT_TYPES, message:
    "%{value} should be 'private' or 'public'" }

  def date_range
    "#{start_date.strftime(DATE_FORMAT)} — #{end_date.strftime(DATE_FORMAT)}"
  end

  def days_between
    days = (start_date.to_date..end_date.to_date).count
    pluralization = 'day'.pluralize(days)
    "Event duration: #{days} #{pluralization}"
  end
end
