class SimpleEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show update destroy]

  def show
  end

  def create
    @simple_event = current_user.simple_events.new(simple_event_params)
    @simple_event.save
    flash.now[:success] = 'Event was succesfully created!'
  end

  def update
    @simple_event.update(simple_event_params)
    flash.now[:success] = 'Event was succesfully updated!'
  end

  def destroy
    @simple_event.destroy
    flash.now[:success] = 'Event was succesfully destroyed!'
  end

  private

  def set_event
    @simple_event = SimpleEvent.find(params[:id])
  end

  def simple_event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :visibility,
                                  :color,
                                  :date,
                                  :duration)
  end
end
