class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status,
            presence: true,
            inclusion: {
              in: %w[admin pending accepted rejected],
              message: "%{value} is not allowed"
            }
  validates_uniqueness_of :user_id, scope: :event_id
end
