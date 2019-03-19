class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
  end

  def show
    @event
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      UserEvent.create(user: current_user, event: @event, status: "admin")

      params[:emails].each do |email|
        password = SecureRandom.hex(10)
        user = User.create!(email: email, password: password, password_confirmation: password)
        UserEvent.create(user: user, event: @event, status: "pending") if user
      end

      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :address, :date)
  end
end
