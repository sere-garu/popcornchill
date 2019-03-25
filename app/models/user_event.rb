class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status,
            presence: true,
            inclusion: {
              in: %w[admin pending accepted rejected],
              message: "%{value} is not allowed"
            }, uniqueness: {
              scope: %i[user_id event_id],
              message: 'one status per user/event pair allowed'
            }
end
