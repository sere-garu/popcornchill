class ResultsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @results = @event.results.order(preference: :desc)
  end

  def create
    raise

    @event = Event.find(params[:event_id])
    @result = @event.results.new(preference: params[:preference])
  end

  private

  def result_params
    params.require(:preference).permit(:preference)
  end
end
