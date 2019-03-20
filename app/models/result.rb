class Result < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  belongs_to :event

  validates :preference,
            presence: true,
            inclusion: {
              in: %w[yep nope],
              message: "%{value} is not allowed"
            }
end
