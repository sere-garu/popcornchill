class Event < ApplicationRecord
  has_many :user_events, dependent: :delete_all
  has_many :users, through: :user_events
  has_many :results, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 30 }
  validates :date, presence: true

  def swiped?
    users.count == results.map(&:user).uniq.count
  end

  def everyone_pending?
    user_events.map(&:status).uniq.sort == %w[admin pending]
  end

  def user_is_admin?(user)
    user_events.where(status: :admin).take.user.name == user.name
  end

  after_create :send_confirm_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end
