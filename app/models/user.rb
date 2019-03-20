class User < ApplicationRecord
  # Devise should handle most validations, so the following may not all be necessary:
  validates :email, presence: true, uniqueness: true, confirmation: true, format: { with: /\A.*@.*\.com\z/ }

  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wishlists
  has_many :movies, through: :wishlists
  has_many :user_events
  has_many :events, through: :user_events
  has_many :results
end
