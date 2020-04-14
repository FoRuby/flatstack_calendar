class UserEventsController < ApplicationController
  before_action :authenticate_user!

  def simple
    @simple_events = current_user.simple_events.all

    render json: @simple_events, adapter: :attributes
  end

  def recurring
    @recurring_events = current_user.recurring_events.all.map(&:events).flatten

    render json: @recurring_events, adapter: :attributes
  end
end
