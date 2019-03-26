class WishlistsController < ApplicationController
  def index
    @wishlists = Wishlist.where(user: current_user, preference: 'yep')

    Wishlist.create_from_api

    @movies_payload = Movie.all
  end

  def create
    @wishlist = current_user.wishlists.create!(wishlist_params)

    redirect_to wishlists_path
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy

    redirect_to wishlists_path
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:user_id, :movie_id, :preference)
  end
end
