class ListingController < ApplicationController
  def index
    render :template=> 'listing/map'
  end
end
