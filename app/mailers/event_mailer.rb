class EventMailer < ApplicationMailer

  def confirm_mail(event)
    @event = event  # Instance variable => available in view
    event.users.each do |user|
      @user = user
      mail(to: user.email, subject: 'Welcome to Popcorn Chill!')
    # This will render a view in `app/views/user_mailer`!
    end
  end
end
