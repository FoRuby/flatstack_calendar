class Event < ApplicationRecord
  COLOR_REGEX = /\A#[0-9a-f]{3,6}\z/i
  EVENT_TYPES = %w[private public]

  scope :public_events, -> { where(visibility: 'public') }
  scope :simple_events, -> { where(type: 'SimpleEvent') }

  validates :title, :visibility, :color, presence: true
  validates :color, format: { with: COLOR_REGEX }
  validates :visibility, inclusion: { in: EVENT_TYPES, message:
    "%{value} should be 'private' or 'public'" }

  def recurring_event?
    type == 'RecurringEvent'
  end

  def simple_event?
    type == 'SimpleEvent'
  end
end
