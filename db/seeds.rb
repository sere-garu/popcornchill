require 'faker'

movies_payload = [
  {
    "title": "The Dark Knight",
    "year": 2008,
    "ids": {
      "trakt": 16,
      "slug": "the-dark-knight-2008",
      "imdb": "tt0468569",
      "tmdb": 155
    }
  },
  {
    "title": "Fight Club",
    "year": 1999,
    "ids": {
      "trakt": 727,
      "slug": "fight-club-1999",
      "imdb": "tt0137523",
      "tmdb": 550
    }
  },
  {
    "title": "Jurassic Park",
    "year": 1993,
    "ids": {
      "trakt": 393,
      "slug": "jurassic-park-1993",
      "imdb": "tt0107290",
      "tmdb": 329
    }
  },
  {
    "title": "Back to the Future",
    "year": 1985,
    "ids": {
      "trakt": 308,
      "slug": "back-to-the-future-1985",
      "imdb": "tt0088763",
      "tmdb": 105
    }
  },
  {
    "title": "The Shawshank Redemption",
    "year": 1994,
    "ids": {
      "trakt": 231,
      "slug": "the-shawshank-redemption-1994",
      "imdb": "tt0111161",
      "tmdb": 278
    }
  },
  {
    "title": "The Social Network",
    "year": 2010,
    "ids": {
      "trakt": 98,
      "slug": "the-social-network-2010",
      "imdb": "tt1285016",
      "tmdb": 37799
    }
  },
  {
    "title": "Star Wars: Episode IV - A New Hope",
    "year": 1977,
    "ids": {
      "trakt": 738,
      "slug": "star-wars-episode-iv-a-new-hope-1977",
      "imdb": "tt0076759",
      "tmdb": 11
    }
  },
  {
    "title": "The Lord of the Rings: The Return of the King",
    "year": 2003,
    "ids": {
      "trakt": 374,
      "slug": "the-lord-of-the-rings-the-return-of-the-king-2003",
      "imdb": "tt0167260",
      "tmdb": 122
    }
  },
  {
    "title": "The Lord of the Rings: The Two Towers",
    "year": 2002,
    "ids": {
      "trakt": 373,
      "slug": "the-lord-of-the-rings-the-two-towers-2002",
      "imdb": "tt0167261",
      "tmdb": 121
    }
  },
  {
    "title": "The Matrix",
    "year": 1999,
    "ids": {
      "trakt": 269,
      "slug": "the-matrix-1999",
      "imdb": "tt0133093",
      "tmdb": 603
    }
  }
]

puts 'Clearing data...'
Result.destroy_all
Wishlist.destroy_all
UserEvent.destroy_all
Movie.destroy_all
Event.destroy_all
User.destroy_all

puts 'Creating movies...'
movies_payload.each { |movie| Movie.create!(trakt_payload: movie) }

puts 'Creating Serena and her wishlist...'
serena = User.create!(email: 'sere@sere.com',
             name: 'Serena',
             password: '123456',
             phone_number: Faker::PhoneNumber.phone_number,
             avatar: 'https://images.ricardocuisine.com/services/recipes/500x675_420.jpg')

puts 'Creating Damiano and his wishlist...'
damiano = User.create!(email: 'dam@dam.com',
             name: 'Damiano',
             password: '123456',
             phone_number: Faker::PhoneNumber.phone_number,
             avatar: 'http://res.freestockavatars.biz/pictures/10/10590-an-orange-cat-isolated-on-a-white-background-pv.jpg')

puts 'Creating Anders and his wishlist...'
anders = User.create!(email: 'anders@anders.com',
             name: 'Anders',
             password: '123456',
             phone_number: Faker::PhoneNumber.phone_number,
             avatar: 'https://img.pngio.com/baby-bengal-tiger-isolated-on-white-background-baby-tiger-png-363_280.jpg')

puts 'Creating Oscar and his wishlist...'
oscar = User.create!(email: 'oscar@oscar.com',
             name: 'Oscar',
             password: '123456',
             phone_number: Faker::PhoneNumber.phone_number,
             avatar: 'http://pluspng.com/img-png/png-cute-cat-our-services-facilities-1698.jpg')

preferences = %w[yep nope]
User.all.each do |user|
  Movie.all.each do |movie|
    next if (1..5).include? (1..10).to_a.sample
    user.wishlists.create(movie: movie, preference: preferences.sample)
    # Wishlist.create(user: user, movie: movie, preference: preferences.sample)
  end
end

puts 'Creating events...'
2.times do
  Event.create!(name: "#{Faker::Team.mascot} in da #{Faker::House.room}",
                date: Faker::Date.forward(29),
                address: Faker::Address.street_address,
                latitude: Faker::Address.latitude,
                longitude: Faker::Address.longitude)
end

puts 'Creating user events...'
status = %w[admin pending accepted rejected]
UserEvent.create!(user_id: serena.id, event_id: Event.all[0].id, status: status[0])
UserEvent.create!(user_id: damiano.id, event_id: Event.all[0].id, status: status[2])
UserEvent.create!(user_id: oscar.id, event_id: Event.all[1].id, status: status[0])
UserEvent.create!(user_id: anders.id, event_id: Event.all[1].id, status: status[2])
UserEvent.create!(user_id: damiano.id, event_id: Event.all[1].id, status: status[2])

puts 'Creating results...'
Event.all.each do |event|
  movie_ids = event.users.map { |user| user.wishlists.where(preference: 'yep').pluck(:movie_id) }.flatten.uniq
  # puts "movie_ids ---> #{movie_ids}"

  all_movies = Movie.where(id: movie_ids)

  all_movies.each do |movie|
    event.users.each do |user|
      # puts "Result <--- #{user.email} -> #{movie.id}"
      Result.create!(event: event, movie: movie, user: user, preference: preferences.sample)
    end
  end
end
