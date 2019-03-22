class Result < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  belongs_to :event

  validates :preference,
            presence: true,
            inclusion: {
              in: %w[yep nope],
              message: "%{value} is not allowed"
            }, uniqueness: { scope: %i[movie_id user_id event_id] }
  # validates_uniqueness_of :user_id, scope: %i[movie_id event_id]
end
