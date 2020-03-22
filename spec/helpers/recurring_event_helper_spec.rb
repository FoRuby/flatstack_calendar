require 'rails_helper'

describe RecurringEventHelper do
  describe '.create_recurrence' do
    subject { RecurringEventHelper }

    it 'with SCHEDULE_TYPES' do
      RecurringEventHelper::SCHEDULE_TYPES.each do |schedule_type|
        recurrence_hash = subject.create_recurrence(schedule_type).to_h

        expect(recurrence_hash).to have_key(:every)
        expect(recurrence_hash[:every]).to eq schedule_type.to_sym
      end
    end
  end

  describe '#next_date(next_date)' do
    let(:recurring_event) do
      create :recurring_event, :daily, start_date: Date.current,
                                       end_date: Date.current + 1
    end

    subject { recurring_event }

    it 'date include in recurring_event dates' do
      expect(subject.next_date(Date.today)).to eq Date.tomorrow
    end

    it 'date exclude in recurring_event dates' do
      expect(subject.next_date(Date.yesterday)).to be_nil
    end
  end
end
