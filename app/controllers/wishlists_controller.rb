class WishlistsController < ApplicationController
  def index
    @wishlists = Wishlist.where(user: current_user, preference: 'yep')

    Wishlist.create_from_api

    @movies_payload = params[:q].present? ? Movie.where("trakt_payload->>'title' ILIKE ?", "%#{params[:q]}%") : Movie.all
  end

  def watchlist
    @wishlists = Wishlist.where(user: current_user, preference: 'yep')
  end

  def create
    @wishlist = current_user.wishlists.create(wishlist_params)
    @movie = Movie.find(params[:wishlist][:movie_id])
    respond_to do |format|
      format.html { redirect_to wishlists_path }
      format.js
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:user_id, :movie_id, :preference)
  end
end
