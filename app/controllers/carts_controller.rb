class CartsController < ApplicationController
  before_action :set_cart, only: %i[ edit update destroy ]
  before_action :authenticate_admin!, only: %i[ index ]

  # GET /carts or /carts.json
  def index
    if current_admin
      @carts = Cart.all
    else
      render :json => {:error => "not-found"}.to_json, :status => 404
    end
  end

  # GET /carts/1 or /carts/1.json
  def show
    @cart = Cart.find_by(user_id: current_user.id)
    if !@cart
      render :json => {:error => "not-found"}.to_json, :status => 404
    else
      @cart_items = @cart.cart_items
      json = @cart_items.to_a.map! do |cart_item|
        cart_item.as_json.merge({
          item: cart_item.item,
          total: cart_item.total_price,
          images: cart_item.item.images.attachments.map do |attachment|
            url_for(attachment)
          end
        })
      end
      render json: json
    end
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params, user_id: current_user.id)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    if @cart.user == current_user
      @cart.destroy
      respond_to do |format|
        format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      render :json => {:error => "not-found"}.to_json, :status => 404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
