class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status,
            presence: true,
            inclusion: {
              in: %w[admin pending accepted rejected],
              message: "%{value} is not allowed"
            }, uniqueness: { scope: %i[movie_id user_id] }
  # validates_uniqueness_of :user_id, scope: :event_id
end
