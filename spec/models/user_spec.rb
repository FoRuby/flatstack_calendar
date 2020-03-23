require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'associations' do
    it { should have_many(:recurring_events) }
    it { should have_many(:simple_events) }
  end

  describe 'scopes' do
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'methods' do
  end
end
