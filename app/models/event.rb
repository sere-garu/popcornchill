class Event < ApplicationRecord
  has_many :user_events, dependent: :delete_all
  has_many :users, through: :user_events
  has_many :results, dependent: :delete_all

  validates :date,
            presence: true
            # uniqueness: {
            #   scope: :address,
            #   message: 'one event per date/address pair allowed'
            # }

  def everyone_swiped?(matches)
    # users.take(users.length).length * matches.size == results.map(&:user).count
    @accepted_users = user_events.pluck(:status).delete_if { |s| s == 'pending' }.count
    @accepted_users * matches.count == results.pluck(:user_id).count
  end

  def someone_new_accepted?
    # user_events.where(status: 'accepted').any?
    user_events.pluck(:status).count('accepted') == @accepted_users - 1
  end

  def user_already_swiped(user, movie)
    results.where(user: user, movie: movie).any?
  end

  # Not in use

  def everyone_pending?
    user_events.map(&:status).uniq.sort == %w[admin pending]
  end
end
