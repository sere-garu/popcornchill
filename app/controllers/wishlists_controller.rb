class WishlistsController < ApplicationController
  def index
    @movies = Movie.all
    @wishlists = Wishlist.where(user: current_user, preference: 'yep')
  end

  def create
    @wishlist = current_user.wishlists.new(wishlist_params)

    if @wishlist.save
      flash[:notice] = "#{Wishlist.all.count} results"
    else
      flash[:notice] = @wishlist.errors.full_messages
    end
    redirect_to wishlists_path
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])

    if @wishlist.destroy
      redirect_to wishlists_path
    else
      render :index
    end
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:movie_id, :preference, :user_id)
  end
end
