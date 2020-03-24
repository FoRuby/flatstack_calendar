require 'rails_helper'

RSpec.describe RecurringEvent, type: :model do
  let(:recurring_event) { create :recurring_event, :daily }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'scopes' do
  end

  describe 'validations' do
    let(:recurring_event_with_invalid_date) do
      build :recurring_event, :daily, start_date: Date.current + 2,
                                      end_date: Date.current + 1
    end

    subject { build :recurring_event, :daily }

    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }

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
          expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe 'methods' do
    context '#dates' do
      let(:recurring_event) do
        build :recurring_event,
              :daily,
              start_date: Date.current,
              end_date: Date.current + 10
      end

      it 'should return dates array' do
        input = recurring_event.dates
        output = Montrose.every(
          :day,
          starts: recurring_event.start_date,
          until: recurring_event.end_date
        ).map(&:to_date)

        expect(input).to eq output
      end
    end

    context '#next_date' do
      let(:recurring_event) do
        create :recurring_event,
               :daily,
               start_date: Date.today,
               end_date: Date.tomorrow
      end

      context 'next date exist' do
        it 'should return next event date' do
          expect(recurring_event.next_date(Date.today))
            .to eq Date.tomorrow
        end
      end

      context 'next date does not exist' do
        it 'should return nil' do
          expect(recurring_event.next_date(Date.tomorrow))
            .to be_nil
        end
      end
    end
    context '#events' do
      let(:recurring_event) do
        create :recurring_event,
               :weekly,
               start_date: Date.today,
               end_date: Date.today + 1.week
      end

      it 'should return recurring_events collection' do
        event1 = RecurringEvent.new(recurring_event.attributes)
        event1.start_date = Date.today
        event1.end_date = Date.today + 1

        event2 = RecurringEvent.new(recurring_event.attributes)
        event2.start_date = Date.today + 1.week
        event2.end_date = Date.today + 8.days

        expect(recurring_event.events).to match_array [event1, event2]
      end
    end
  end
end
