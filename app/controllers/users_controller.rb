class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :profile]
  before_action :set_user, only: [:show, :update]

  # GET /users/1
  def profile
    @user = User.find(current_user.id)
    @order = Order.where(user_id: current_user.id)
    
    respond_to do |format|
      format.json  { render :json => {:user => @user, 
                                  :order => @order }}
                                 #     render json: @user (include: [:doctor, :patient])
      end 
  end

  def show
    render json: @user
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name)
    end
end
