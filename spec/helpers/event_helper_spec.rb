require 'rails_helper'

RSpec.describe EventHelper, type: :helper do
  let(:simple_event) { create :simple_event, date: Date.current, duration: 5 }

  describe '#format' do
    context 'start_end' do
      it 'return string sample 17 March 2020 — 22 March 2020' do
        event_start = simple_event.date.to_formatted_s(:rfc822)
        event_end = simple_event.end_date.to_formatted_s(:rfc822)

        expect(helper.format(simple_event, :start_end))
          .to eq "#{event_start} — #{event_end}"
      end
    end

    context 'duration' do
      it 'return event duration' do
        expect(helper.format(simple_event, :duration))
          .to eq 'Event duration: 5 days'
      end
    end

    context 'author' do
      it 'return event author' do
        expect(helper.format(simple_event, :author))
          .to eq "Author: #{simple_event.user.name}"
      end
    end
  end
end
