class EventMailer < ApplicationMailer

  # def welcome(user)
  #   @user = user  # Instance variable => available in view

  #   mail(to: @user.email, subject: 'Welcome to Popcorn Chill!')
  #   # This will render a view in `app/views/user_mailer`!
  # end


  if user.user_events.where(status: 'admin')
    def confirm
      @user = user

      mail to: @user.email, subject: "Your Event is on its way!"
    end
  else
    def invite
      @user = user

      mail to: @user.email, subject: "You have been invited!"
    end
  end

end
