class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :preference,
            presence: true,
            inclusion: {
              in: %w[yep nope],
              message: "%{value} is not allowed"
            }
  validates_uniqueness_of :user_id, scope: :movie_id

  def self.create_from_api
  	movies = Movie.movies_from_api

  	movies.each do |movie|
  		next if Movie.where("trakt_payload->>'title' = ?", movie["title"]).first
  		Movie.create(trakt_payload: movie)
  	end
  end
end
