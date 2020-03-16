require 'rails_helper'

RSpec.describe RecurringEvent, type: :model do
  let(:recurring_event) { create(:recurring_event, :daily) }
  let(:ice_cube_schedule) do
    IceCube::Schedule.new(recurring_event.date) do |schedule|
      schedule.add_recurrence_rule(IceCube::Rule.daily)
    end
  end

  describe 'associations' do
  end

  describe 'scopes' do
  end

  describe 'validations' do
    let(:recurring_event_with_invalid_date) do
      build(:recurring_event, date: Date.current,
                              recurring_start_date: Date.current + 2,
                              recurring_end_date: Date.current + 1)
    end

    subject { build(:recurring_event) }

    it { should validate_presence_of :schedule }

    describe 'custom' do
      context 'validate_event_date_should_be_in_recurring_range' do
        subject { recurring_event_with_invalid_date }

        it 'recurring_event should be invalid' do
          subject.valid?

          expect(subject.errors[:date])
            .to include('should be in recurring range')
        end

        it 'should raise error' do
          expect { subject.save! }
            .to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe 'methods' do
    context '#dates' do
      it 'should return dates array' do
        input = recurring_event.dates
        output = ice_cube_schedule
                 .occurrences(recurring_event.recurring_end_date.to_time)
                 .map(&:to_date)
        expect(input).to eq output
      end
    end
  end
end
