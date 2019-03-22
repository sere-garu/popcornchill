class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @pending_events = current_user.user_events.where(status: 'pending').map(&:event).reverse
    @admin_events = current_user.user_events.where(status: 'admin').map(&:event).reverse
    @accepted_events = current_user.user_events.where(status: 'accepted').map(&:event).reverse
  end

  def show
    @movies = Movie.in_common(@event)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      UserEvent.create(user: current_user, event: @event, status: 'admin')
      event_friends(params[:emails], @event)
      flash[:notice] = "#{Event.all.count} events"
      redirect_to root_path
    else
      flash[:notice] = @wishlist.errors.full_messages
      render 'new'
    end
  end

  def edit; end

  def update
    @event.update(event_params)

    if @event.save
      event_friends(params[:emails], @event)
      flash[:notice] = "#{Event.all.count} events"
      redirect_to root_path
    else
      flash[:notice] = @wishlist.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "#{Event.all.count} events"
    redirect_to root_path
  end

  private

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
      next if User.where(email: email).take
      next if email.blank?

      password = SecureRandom.hex(10)
      temp_user = User.create!(email: email, password: password, password_confirmation: password)
      UserEvent.create(user: temp_user, event: event) if temp_user
    end
  end
end
