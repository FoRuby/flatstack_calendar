class Event < ApplicationRecord
  attr_accessor :date_range

  COLOR_REGEX = /\A#[0-9a-f]{3,6}\z/i
  EVENT_TYPES = %w[private public]

  scope :public_events, -> { where(event_type: 'public') }

  validates :title, :start_date, :event_type, :color, presence: true
  validates :color, format: { with: COLOR_REGEX }
  validates :event_type, inclusion: { in: EVENT_TYPES, message:
    "%{value} should be 'private' or 'public'" }
end
