class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
    render json: @events, adapter: :attributes
  end

  def show
    render json: @event
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def update
    @event.update(event_params)
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
