class UserEventsController < ApplicationController
  def update
    event = Event.find(params[:id])
    user_event = event.user_events.where(user: current_user).take.update(status: 'accepted')

    if user_event
      flash[:notice] = "#{UserEvent.all.count} user events"
    else
      flash[:notice] = user_event.errors
    end
    redirect_to events_path
  end

  def destroy
    event = Event.find(params[:id])
    event.user_events.where(user: current_user).take.destroy
    flash[:notice] = "#{UserEvent.all.count} user events"
    redirect_to events_path
  end
end
