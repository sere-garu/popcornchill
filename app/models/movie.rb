class Movie < ApplicationRecord
  has_many :wishlists
  has_many :users, through: :wishlists


  validates :trakt_payload, presence: true

end
