require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }
  let(:event_without_end_date) { create(:event, callback?: false) }

  describe 'associations' do
    # it { should belong_to(:user) }
  end

  describe 'scopes' do
    let!(:public_event1) { create(:event, event_type: 'public') }
    let!(:public_event2) { create(:event, event_type: 'public') }
    let!(:private_event) { create(:event) }

    context "public_events scope by event: 'public'" do
      subject { Event.public_events.to_a }

      it { is_expected.to match_array [public_event1, public_event2] }
    end
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :event_type }
    it { should validate_presence_of :color }

    it { should allow_value(Faker::Color.hex_color).for(:color) }
    it { should_not allow_value('color', '#11223344', '#12').for(:color) }

    it { should allow_value('private', 'public').for(:event_type) }
    it { should_not allow_value(1, 'foo', :bar).for(:event_type) }
  end

  describe 'methods' do
    describe '#date_range' do
      context 'event without end date' do
        it 'return only formated start date' do
          expect(event_without_end_date.date_range)
            .to eq event_without_end_date.start_date.strftime(Event::DATE_FORMAT)
        end
      end

      context 'event with start and end date' do
        it 'return date range' do
          start_date = event.start_date.strftime(Event::DATE_FORMAT)
          end_date = event.end_date.strftime(Event::DATE_FORMAT)

          expect(event.date_range).to eq "#{start_date} — #{end_date}"
        end
      end
    end
    describe '#days_between' do
      context 'event without end date' do
        it 'return message' do
          expect(event_without_end_date.days_between)
            .to eq 'Event end date not set'
        end
      end

      context 'event with start and end date' do
        let(:event) do
          create(:event, start_date: Date.current,
                         end_date: Date.current + 1,
                         callback?: false)
        end

        it 'return event duration' do
          expect(event.days_between).to eq 'Event duration: 2 days'
        end
      end
    end
  end
end
