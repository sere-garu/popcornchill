class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :preference,
            presence: true,
            inclusion: {
              in: %w[yep nope],
              message: "%{value} is not allowed"
            }
  validates_uniqueness_of :user_id, scope: :movie_id
end
