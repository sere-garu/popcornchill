class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @pending_events = current_user.user_events.where(status: 'pending').reverse
    @events = Event.all.reverse
  end

  def show
    @movies = event_movies(@event)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      UserEvent.create(user: current_user, event: @event, status: 'admin')

      User.where(email: params['emails']).each do |user|
        UserEvent.create(user: user, event: @event)
      end

      params[:emails].each do |email|
        next if User.where(email: email).take
        next if email.blank?

        password = SecureRandom.hex(10)
        temp_user = User.create!(email: email, password: password, password_confirmation: password)
        UserEvent.create(user: temp_user, event: @event) if temp_user
      end

      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @event
  end

  def update
    @event
    @event.update(event_params)
    if @event.save
      redirect_to root_path
    else
      render 'edit'
    end
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

  def event_movies(event)
    @movies = []
    event.users.each do |user|
      next unless user.user_events.where(event_id: params[:id]).take.status == 'accepted'

      @movies << user.movies
    end
    @movies.flatten.uniq
  end

  def event_params
    params.require(:event).permit(:preference, :name, :date, :address, :latitude, :longitude)
  end
end
