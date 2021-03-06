class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @pending_events = user_events_filter('pending')
    @admin_events = user_events_filter('admin')
    @accepted_events = user_events_filter('accepted')
  end

  def show
    @movies = Movie.in_common(@event)

    if @event.everyone_swiped?(@movies)
      redirect_to event_results_path(@event)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      UserEvent.create(user: current_user, event: @event, status: 'admin')
      event_friends(params[:emails], @event)
      redirect_to events_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @event.update(event_params)

    if @event.save
      event_friends(params[:emails], @event)
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def user_events_filter(preference)
    current_user.user_events.where(status: preference).map(&:event).reverse
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :address, :date)
  end

  def event_friends(emails, event)
    User.where(email: emails).each do |user|
      UserEvent.create(user: user, event: event)
    end

    emails.each do |email|
      next if email.blank?
      # next if User.where(email: email).take
      next if User.pluck(:email).include?(email)

      password = SecureRandom.hex(10)
      temp_user = User.create!(email: email, password: password, password_confirmation: password)
      UserEvent.create(user: temp_user, event: event) if temp_user
    end
  end
end
