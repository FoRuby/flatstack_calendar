require 'rails_helper'

describe EventHelper do
  let(:event) { create(:event, date: Date.current, duration: 5) }
  describe '#format' do
    context 'start_end' do
      it 'return string sample 17 March 2020 — 22 March 2020' do
        event_start = event.date.to_formatted_s(:rfc822)
        event_end = event.end_date.to_formatted_s(:rfc822)

        expect(helper.format(event, :start_end))
          .to eq "#{event_start} — #{event_end}"
      end
    end

    context 'duration' do
      it 'return event duration' do
        expect(helper.format(event, :duration))
          .to eq 'Event duration: 5 days'
      end
    end
  end
end
