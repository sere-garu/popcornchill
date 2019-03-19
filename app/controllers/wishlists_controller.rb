class WishlistsController < ApplicationController
  def index
    @wishlists = Wishlist.all
  end

  def new
    @user = current_user
    @wishlist = Wishlist.new
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)
    @wishlist.user = current_user

    # double-check 
    render 'new' if @wishlist.save
  end

  def edit
  end

  def update
    if @instrument.update(instrument_params)
      redirect_to @instrument
    else
      # double-check 
      render 'edit'
    end
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:preference)
  end

end
