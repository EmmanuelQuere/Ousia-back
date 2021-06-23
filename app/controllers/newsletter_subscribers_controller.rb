class NewsletterSubscribersController < ApplicationController

  def index
    @subscribers = NewsletterSubscriber.all
  end

  def create
    @subscriber = NewsletterSubscriber.find_or_create_by(email: post_params[:email])

    respond_to do |format|
      if @subscriber.save
        format.json { render :json, status: :created, location: @subscriber }
      else
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.permit(:email)
  end
end
