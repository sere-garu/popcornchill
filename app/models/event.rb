class Event < ApplicationRecord
  has_many :user_events, dependent: :delete_all
  has_many :users, through: :user_events
  has_many :results, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 50 }
  validates :date, presence: true

  def results?
    results.map(&:user_id).uniq.count.positive?
  end

  def everyone_pending?
    user_events.map(&:status).uniq.sort == %w[admin pending]
  end

  def someone_accepted?
    user_events.where(status: 'accepted').any?
  end

  # def new_movies?
  #   user_events.where(status: 'accepted').take.nil?
  # end

  def everyone_swiped?
    users.count == results.map(&:user).uniq.count
  end

  def admin?(user)
    user_events.where(status: :admin).take.user.name == user.name
  end

  def user_already_swiped(user, movie)
    self.results.where(user: user, movie: movie).any?
  end
end
