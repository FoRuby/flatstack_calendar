class RecurringEventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]

  def show
    @next_date =
      @recurring_event.next_date(recurring_event_params[:start_date])
  end

  def create
    @recurring_event = RecurringEvent.new(recurring_event_params)
    @recurring_event.save
    flash.now[:success] = 'Event was succesfully created!'
  end

  def update
    @recurring_event.update(recurring_event_params)
    flash.now[:success] = 'Event was succesfully updated!'
  end

  def destroy
    @recurring_event.destroy
    flash.now[:success] = 'Event was succesfully destroyed!'
  end

  private

  def set_event
    @recurring_event = RecurringEvent.find(params[:id])
  end

  def recurring_event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :visibility,
                                  :color,
                                  :start_date,
                                  :end_date,
                                  :schedule_type)
  end
end
