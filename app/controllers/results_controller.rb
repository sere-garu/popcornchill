class ResultsController < ApplicationController
  before_action :set_event, only: %i[index create]

  def index
    @results = @event.results.order(preference: :desc)
  end

  def create
    @result = @event.results.new(result_params)
    if @result.save
      flash[:notice] = "#{Result.all.count} results"
    else
      flash[:notice] = @result.errors
    end
    redirect_to event_path @event
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def result_params
    params.permit(:preference, :movie_id, :user_id, :event_id)
  end
end

