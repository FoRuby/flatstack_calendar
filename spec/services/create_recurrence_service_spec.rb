require 'rails_helper'

RSpec.describe CreateRecurrenceService, type: :service do
  describe '.call' do
    subject { CreateRecurrenceService }

    it 'should create recurrence' do
      CreateRecurrenceService::SCHEDULE_TYPES.each do |schedule_type|
        recurrence_hash = subject.call(schedule_type).to_h

        expect(recurrence_hash).to have_key(:every)
        expect(recurrence_hash[:every]).to eq schedule_type.to_sym
      end
    end
  end
end
