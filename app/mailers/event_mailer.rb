class EventMailer < ApplicationMailer

    def confirm_mail(event)
    @event = event  # Instance variable => available in view
    mail(to: current_user, subject: 'Welcome to Popcorn Chill!')
    # This will render a view in `app/views/user_mailer`!
  end
end
