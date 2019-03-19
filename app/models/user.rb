class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wishlists
  has_many :movies, through: :wishlists
  has_many :user_events
  has_many :events, through: :user_events
  has_many :results
end
