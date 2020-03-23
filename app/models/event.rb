class Event < ApplicationRecord
  scope :public_events, -> { where(visibility: 'public') }
  scope :private_events, -> { where(visibility: 'private') }

  COLOR_REGEX = /\A#[0-9a-f]{3,6}\z/i
  EVENT_TYPES = %w[private public]

  belongs_to :user

  validates :title, :visibility, :color, presence: true
  validates :color, format: { with: COLOR_REGEX }
  validates :visibility, inclusion: { in: EVENT_TYPES, message:
    "%{value} should be 'private' or 'public'" }
end
