class EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
    flash.now[:success] = 'Event was succesfully created!'
  end

  def update
    @event.update(event_params)
    flash.now[:success] = 'Event was succesfully updated!'
  end

  def destroy
    @event.destroy
    flash.now[:success] = 'Event was succesfully destroyed!'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :date,
                                  :duration,
                                  :visibility,
                                  :color,
                                  :shedule,
                                  :recurring_start_date,
                                  :recurring_end_date)
  end
end
