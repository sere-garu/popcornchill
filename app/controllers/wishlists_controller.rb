class WishlistsController < ApplicationController
  def index
    @wishlists = Wishlist.where(user: current_user, preference: 'yep')
    @movies_payload = Movie.all
  end

  def create
    @wishlist = current_user.wishlists.new(wishlist_params)

    if @wishlist.save
      flash[:notice] = "#{Wishlist.all.count} wishlists"
    else
      flash[:notice] = @wishlist.errors.full_messages
    end
    redirect_to wishlists_path
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])

    if @wishlist.destroy
      flash[:notice] = "#{Wishlist.all.count} wishlists"
    else
      flash[:notice] = @wishlist.errors.full_messages
    end
    redirect_to wishlists_path
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:user_id, :movie_id, :preference)
  end
end
