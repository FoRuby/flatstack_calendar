require 'rails_helper'

RSpec.describe SimpleEvent, type: :model do
  let(:simple_event) { create(:simple_event) }

  describe 'associations' do
    # it { should belong_to(:user) }
  end

  describe 'scopes' do
  end

  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :duration }

    it { should validate_numericality_of(:duration).is_greater_than(0) }
  end

  describe 'methods' do
    describe '#end_date' do
      it 'return event end date' do
        expect(simple_event.end_date)
          .to eq simple_event.date + simple_event.duration
      end
    end
  end
end
