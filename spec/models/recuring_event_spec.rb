require 'rails_helper'

RSpec.describe RecurringEvent, type: :model do
  let(:recurring_event) { create(:recurring_event, :daily) }

  describe 'associations' do
  end

  describe 'scopes' do
  end

  describe 'validations' do
    let(:recurring_event_with_invalid_date) do
      build(:recurring_event, start_date: Date.current + 2,
                              end_date: Date.current + 1)
    end

    subject { build(:recurring_event) }

    it { should validate_presence_of :schedule }
    # it { should validate_presence_of :start_date }
    # it { should validate_presence_of :end_date }

    RecurringEvent::SCHEDULE.each do |value|
      it { should allow_value(value).for(:schedule) }
    end

    it { should_not allow_value(1, 'foo', :bar).for(:schedule) }

    describe 'custom' do
      context 'validate_end_date_should_be_greater_then_start_date' do
        subject { recurring_event_with_invalid_date }

        it 'recurring_event should be invalid' do
          subject.valid?

          expect(subject.errors[:start_date])
            .to include('should be less then end date')
          expect(subject.errors[:end_date])
            .to include('should be greater then start date')
        end

        it 'should raise error' do
          expect { subject.save! }
            .to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe 'methods' do
    # context '#dates' do
    #   it 'should return dates array' do
    #     input = recurring_event.dates
    #     output = ice_cube_schedule
    #              .occurrences(recurring_event.end_date.to_time)
    #              .map(&:to_date)
    #     expect(input).to eq output
    #   end
    # end
  end
end
