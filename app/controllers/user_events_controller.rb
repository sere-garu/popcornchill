class UserEventsController < ApplicationController
  def update
    user_event = UserEvent.find(params[:id])
    user_event.update(user_event_params)

    if user_event.save
      flash[:notice] = "#{UserEvent.all.count} user events"
    else
      flash[:notice] = user_event.errors
    end
    redirect_to root_path
  end

  private

  def user_event_params
    params.require(:pending).permit(:status, :user_id, :event_id)
  end

  # def common_wishlists(event)
  #   users_wishlists = []
  #   event.users.map do |user|
  #     next if %w[pending rejected].include? event.user_events.where(user: user).take.status

  #     user.wishlists.each { |w| users_wishlists << [user.id, w.movie_id, w.preference] }
  #   end
  #   users_wishlists.delete_if { |w| w.include? 'nope' }
  #   users = users_wishlists.map(&:shift)
  #   h = {}
  #   users.each_with_index { |u, i| h[u] = users_wishlists[i] }
  #   h.each do |user, v|
  #     result = event.results.new(user_id: user, movie_id: v[0], preference: v[1], event_id: event.id)
  #     if result.save
  #       flash[:notice] = "#{Result.all.count} results"
  #     else
  #       flash[:notice] = result.errors
  #     end
  #   end
  # end
end
