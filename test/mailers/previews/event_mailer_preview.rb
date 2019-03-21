# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/confirm
  def confirm
    EventMailer.confirm
  end

  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/invite
  def invite
    EventMailer.invite
  end

end
