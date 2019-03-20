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

  # validate that Events have at least two members (admin && invitee)
  def invited?
    user_events.user_id.count >= 2
  end
end
