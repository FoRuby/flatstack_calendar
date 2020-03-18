class CalendarController < ApplicationController
  def calendar
    @simple_event = SimpleEvent.new
    @recurring_event = RecurringEvent.new
  end

  def simple_events
    @simple_events = SimpleEvent.public_events.all
  end

  def recurring_events
    @recurring_events = RecurringEvent.public_events.all
  end
end
