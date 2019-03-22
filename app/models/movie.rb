class Movie < ApplicationRecord
  has_many :wishlists
  has_many :users, through: :wishlists

  validates :trakt_payload, presence: true

  def self.in_common(event)
    movies = []

    event.users.each do |user|
      next if %w[rejected pending].include? user.user_events.where(event: event).take.status

      movie_ids_for_user = user.movies.pluck(:id)
      movies << movie_ids_for_user
    end

    uniq_movies = movies.flatten

    duplicates = uniq_movies.select { |id| uniq_movies.count(id) > 1 }

    where(id: duplicates.uniq)
  end

  def preference?(user)
    user.wishlists.pluck(:movie_id).include? id
  end

  # def yep?(user)
  #   user_wishlist = user.wishlists.where(movie: self)
  #   user_wishlist.empty? ? false : user_wishlist.take.preference == 'yep'
  # end

  def result?(user)
    # user.user_events
  end
end
