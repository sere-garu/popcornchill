class ResultsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @results = @event.results.reject { |r| r.preference == 'nope' }

    user_wishlists = @event.users.map do |user|
      a = user.wishlists.pluck :movie_id
      b = user.wishlists.pluck :preference
      a.map do |e|
        [e, b[a.index(e)]]
      end
    end.flatten.each_slice(2).to_a

    c = user_wishlists.select { |e| user_wishlists.count(e) > 1 }.uniq
    # try to have only yeps
    # use the resulting index to find that movie and push it in results
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

  def set_event; end

  def result_params
    params.permit(:preference, :movie_id, :user_id, :event_id)
  end
end
