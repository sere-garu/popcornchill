class ResultsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])

    pre_results = @event.results.reject { |r| r.preference == 'nope' }
    movie_ids = pre_results.pluck(:movie_id)

    matches = movie_ids.select { |e| movie_ids.count(e) > 1 }

    @matches_count = matches.uniq.map { |e| matches.count(e) }

    results_count = @event.results.where(movie: matches)
    @results = results_count.map(&:movie).uniq

    @users_count = @event.users.count
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

  def set_event; end

  def result_params
    params.permit(:preference, :movie_id, :user_id, :event_id)
  end
end
