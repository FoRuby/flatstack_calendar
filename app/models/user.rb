class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

  has_many :recurring_events
  has_many :simple_events

  validates :name, presence: true

  def author?(item)
    return false unless item.respond_to?(:user)

    id == item.user_id
  end
end
