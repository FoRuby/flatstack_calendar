require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }

  describe 'associations' do
    # it { should belong_to(:user) }
  end

  describe 'scopes' do
    subject { build(:event) }

    let!(:public_event1) { create(:event, visibility: 'public') }
    let!(:public_event2) { create(:event, visibility: 'public') }
    let!(:private_event) { create(:event) }

    context "public_events scope by event: 'public'" do
      subject { Event.public_events.to_a }

      it { is_expected.to match_array [public_event1, public_event2] }
    end
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :date }
    it { should validate_presence_of :visibility }
    it { should validate_presence_of :color }


    it { should validate_numericality_of(:duration).is_greater_than(0) }

    it { should allow_value(Faker::Color.hex_color).for(:color) }
    it { should_not allow_value('color', '#11223344', '#12').for(:color) }

    it { should allow_value('private', 'public').for(:visibility) }
    it { should_not allow_value(1, 'foo', :bar).for(:visibility) }
  end

  describe 'methods' do
    describe '#end_date' do
      it 'return event end date' do
        expect(event.end_date).to eq event.date + event.duration
      end
    end
  end
end
