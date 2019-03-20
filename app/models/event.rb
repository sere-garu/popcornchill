class Event < ApplicationRecord
  has_many :users, through: :user_events

  has_many :user_events, dependent: :delete_all
  has_many :results, dependent: :delete_all
end
