class StoreLocationsController < ApplicationController
  def index
    @stores = StoreLocation.all
    render json: @stores
  end
end
