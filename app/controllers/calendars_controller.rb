class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    @simple_event = SimpleEvent.new
    @recurring_event = RecurringEvent.new
  end
end
