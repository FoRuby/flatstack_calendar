require 'rails_helper'

RSpec.describe RecurringEventHelper, type: :service do
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
