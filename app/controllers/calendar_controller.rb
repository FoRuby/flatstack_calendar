class CalendarController < ApplicationController
  def calendar
    @event = FactoryBot.build(:event)
    @recurring_event = FactoryBot.build(:recurring_event)
  end

  def simple_events
    @events = Event.public_events.simple_events.all
  end

  def recurring_events
    @recurring_events = RecurringEvent.public_events.all
  end
end
