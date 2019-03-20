class WishlistsController < ApplicationController
  def index
    @movies = Movie.all
  end
end
