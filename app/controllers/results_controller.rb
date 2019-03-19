class ResultsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @results = @event.results.order(preference: :desc)
  end

  def new
    @event = Event.find(params[:event_id])
    @movies = event_movies(@event)
    @result = @event.results.new
  end

  def create
    raise

    @event = Event.find(params[:event_id])
    @result = @event.results.new(preference: params[:preference])
  end

  private

  def event_movies(event)
    @movies = []
    event.users.each do |user|
      @movies << user.movies
    end
    @movies.flatten.uniq
  end
end
