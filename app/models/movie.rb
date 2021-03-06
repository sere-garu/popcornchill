class Movie < ApplicationRecord
  has_many :wishlists
  has_many :users, through: :wishlists

  validates :trakt_payload, presence: true

  ROOT_URL = "https://api.trakt.tv/"
  # TOKEN_PATH = "oauth/device/token"
  # DEVICE_PATH = "oauth/device/code"
  # MOVIES_PATH = "recommendations/movies?ignore_collected=false"
  MOVIES_PATH = "recommendations/movies?ignore_collected=false&limit=100"


  AUTH = {
    client_id: 'edfb16eb6a0bd6e5b70834648d9bb4a7531a86ca81cb67d55f8c6d545dcee3af',
    client_secret: '88759f697eed5414ae3de38d6c64cc66f5bb59f24df5f5dd13c2b448dc99b3c6',
  }


  def self.in_common(event)
    movies = []

    event.users.each do |user|
      next if %w[rejected pending].include? user.user_events.where(event: event).take.status

      # movie_ids_for_user = user.wishlists.where(preference: "yep").pluck(:movie_id)
      movie_ids_for_user = user.movies.pluck(:id)

      movies << movie_ids_for_user
    end

    uniq_movies = movies.flatten.uniq

    # duplicates = uniq_movies.select { |id| uniq_movies.count(id) > 1 }

    where(id: uniq_movies)
  end

  def self.movies_from_api
    headers = {
      :content_type => 'application/json',
      :authorization => 'Bearer fad2d7ad0800c90c5db21f973a93626ef0cd603f71ff80fee461f69d663a049e',
      :trakt_api_version => '2',
      :trakt_api_key => AUTH[:client_id]
    }

    data = RestClient.get "#{ROOT_URL}#{MOVIES_PATH}", headers
    JSON.parse(data)
  end

  def image_url
    # return image frm the json if we have one
    current = self.trakt_payload["image_url"]
    return current if current.present?

    # Save image in the json:
    current_payload = self.trakt_payload
    image_scraped_local = self.image_scraped
    current_payload["image_url"] = image_scraped_local

    self.trakt_payload = current_payload
    self.save

    current_payload["image_url"]
  end

  def image_scraped
    base = "https://www.imdb.com/title/#{self.trakt_payload["ids"]["imdb"]}/"
    html = Nokogiri::HTML(open(base).read)
    html.search('meta[property="og:image"]').first.attributes["content"].to_s
  rescue
    nil
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
