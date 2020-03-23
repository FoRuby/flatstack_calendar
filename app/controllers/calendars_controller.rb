class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
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
    @simple_events = SimpleEvent.user_events(current_user).all

    render json: @simple_events, adapter: :attributes
  end

  def my_recurring_events
    @recurring_events =
      RecurringEvent.user_events(current_user).all.map(&:events).flatten

    render json: @recurring_events, adapter: :attributes
  end
end
