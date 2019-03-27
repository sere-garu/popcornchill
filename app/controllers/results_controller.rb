class ResultsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

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

    @result.user_id = current_user.id

    if @result.save
      # flash[:notice] = "#{Result.all.count} results"
    else
      # flash[:notice] = @result.errors
    end

    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.json { render json: @result }
    end
  end

  private

  def set_event; end

  def result_params
    params.permit(:preference, :movie_id, :user_id, :event_id)
  end
end
