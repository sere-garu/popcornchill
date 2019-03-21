class Movie < ApplicationRecord
  has_many :wishlists
  has_many :users, through: :wishlists

  validates :trakt_payload, presence: true

  def preference?(user)
    user.wishlists.pluck(:movie_id).include? id
  end

  def yep?(user)
    user_wishlist = user.wishlists.where(movie: self)
    user_wishlist.empty? ? false : user_wishlist.take.preference == 'yep'
  end

  def result?(user)
    # user.user_events
  end
end
