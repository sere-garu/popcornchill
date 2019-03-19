class Result < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  belongs_to :event
end
