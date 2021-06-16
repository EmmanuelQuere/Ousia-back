class ApplicationController < ActionController::Base
  skip_forgery_protection
  respond_to :html, :json

end
