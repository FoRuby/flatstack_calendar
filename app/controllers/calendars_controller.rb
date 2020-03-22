class CalendarsController < ApplicationController
  def calendar
    @simple_event = SimpleEvent.new
    @recurring_event = RecurringEvent.new
  end

  def simple_events
    @simple_events = SimpleEvent.public_events.all

    render json: @simple_events, adapter: :attributes
  end

  def recurring_events
    @recurring_events = RecurringEvent.public_events.all.map(&:events).flatten

    render json: @recurring_events, adapter: :attributes
  end

  def my_simple_events
    @simple_events = SimpleEvent.private_events.all

    render json: @simple_events, adapter: :attributes
  end

  def my_recurring_events
    @recurring_events = RecurringEvent.private_events.all.map(&:events).flatten

    render json: @recurring_events, adapter: :attributes
  end
end
