class ResultsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @results = @event.results.order(preference: :desc)
  end

  def new

  end

  def create

  end
end
