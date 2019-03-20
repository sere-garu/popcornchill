class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :preference,
            presence: true,
            inclusion: {
              in: %w[yep nope],
              message: "%{value} is not allowed"
            }, uniqueness: { scope: %i[movie_id user_id] }
end
