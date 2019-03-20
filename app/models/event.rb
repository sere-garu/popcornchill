class Event < ApplicationRecord
  has_many :user_events, dependent: :delete_all
  has_many :users, through: :user_events
  has_many :results, dependent: :delete_all

  def swiped?
    users.count == results.map(&:user).uniq.count
  end

  def everyone_pending?
    user_events.map(&:status).uniq.sort == %w[admin pending]
  end
end
