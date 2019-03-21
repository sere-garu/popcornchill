class ResultsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @results = @event.results.reject { |r| r.preference == 'nope' }
    raise
  end

  def create
    @event = Event.find(params[:event_id])
    @result = @event.results.new(result_params)
    if @result.save
      flash[:notice] = "#{Result.all.count} results"
    else
      flash[:notice] = @result.errors
    end
    redirect_to event_path @event
  end

  private

  def result_params
    params.permit(:preference, :movie_id, :user_id, :event_id)
  end
end
