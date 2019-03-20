class UserEventsController < ApplicationController
  def update
    user_event = UserEvent.find(params[:id])
    user_event.update(user_event_params)
    redirect_to root_path
  end

  private

  def user_event_params
    params.require(:pending).permit(:status, :user_id, :event_id)
  end
end
