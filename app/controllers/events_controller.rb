class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
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
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :start_date,
                                  :end_date,
                                  :event_type,
                                  :color)
  end
end
