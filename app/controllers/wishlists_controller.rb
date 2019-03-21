class WishlistsController < ApplicationController
  def index
    @movies = Movie.order(created_at: :desc)
    @wishlists = Wishlist.where(user_id: current_user).order(created_at: :asc)
  end

  def create
    @wishlist = current_user.wishlists.new(movie_params)

    if @wishlist.save
      redirect_to wishlists_path
    else
      render :index
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])

    if @wishlist.delete
      redirect_to wishlists_path
    else
      render :index
    end
  end

  private

  def movie_params
    params.require(:movie_params).permit(:movie_id, :preference, :user_id)
  end
end
