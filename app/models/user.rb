class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :recurring_events
  has_many :simple_events

  validates :name, presence: true
end
