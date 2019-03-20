class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events
  has_many :results

  def swiped?
    users.count == results.map(&:user).uniq.count
  end

  def everyone_pending?
    user_events.map(&:status).uniq.sort == %w[admin pending]
  end
end
