class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status,
            presence: true,
            inclusion: {
              in: %w[admin pending accepted rejected],
              message: "%{value} is not allowed"
            }
end
