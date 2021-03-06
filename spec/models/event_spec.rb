require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create :event }

  describe 'associations' do
  end

  describe 'scopes' do
    subject { build(:event) }

    let!(:public_event1) { create :simple_event, visibility: 'public' }
    let!(:public_event2) { create :recurring_event, visibility: 'public' }
    let!(:private_event1) { create :simple_event, visibility: 'private' }
    let!(:private_event2) { create :recurring_event, visibility: 'private' }

    context 'public_events' do
      subject { Event.public_events.to_a }

      it { is_expected.to match_array [public_event1, public_event2] }
    end

    context 'private_events' do
      subject { Event.private_events.to_a }

      it { is_expected.to match_array [private_event1, private_event2] }
    end
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :visibility }
    it { should validate_presence_of :color }

    it { should allow_value(Faker::Color.hex_color).for(:color) }
    it { should_not allow_value('color', '#11223344', '#12').for(:color) }

    it { should allow_value('private', 'public').for(:visibility) }
    it { should_not allow_value(1, 'foo', :bar).for(:visibility) }
  end
end
