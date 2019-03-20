class WishlistsController < ApplicationController
  def index
    @movies = Movie.all
    @wishlists = Wishlist.where(user_id: current_user)
  end

  def create
    @wishlist = current_user.wishlists.new(movie_params)
    if @wishlist.save
      redirect_to wishlists_path
    else
      render :index
    end
  end

  def update
    raise
  end

  private

  def movie_params
    params.require(:movie_params).permit(:movie_id, :preference, :user_id)
  end
end
