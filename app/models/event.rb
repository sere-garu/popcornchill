class Event < ApplicationRecord
  has_many :user_events, dependent: :delete_all
  has_many :users, through: :user_events
  has_many :results, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 50 }
  validates :date, presence: true

  def self.endpoint?(event, movies)
    event.results.count == movies.count**2
  end

  def results?
    results.map(&:user_id).uniq.count.positive?
  end

  def everyone_pending?
    user_events.map(&:status).uniq.sort == %w[admin pending]
  end

  def someone_accepted?
    user_events.where(status: 'accepted').any?
  end

  def everyone_swiped?(watchlist)
    users.take(users.length).length * watchlist.size == results.map(&:user).count
  end

  def admin?(user)
    user_events.where(status: :admin).take.user.name == user.name
  end

  def user_already_swiped(user, movie)
    results.where(user: user, movie: movie).any?
  end
end
