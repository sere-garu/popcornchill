class Movie < ApplicationRecord
  has_many :wishlists
  has_many :users, through: :wishlists

  validates :trakt_payload, presence: true

  def preference?(user)
    user.wishlists.pluck(:movie_id).include? id
  end
end
