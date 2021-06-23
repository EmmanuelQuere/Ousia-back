class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ create ]

  # GET /cart_items or /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1 or /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items or /cart_items.json
  def create
    @existing_item = CartItem.find_by(item_id: cart_item_params[:item_id], cart: current_user.cart)
    new_params = cart_item_params.to_h.merge(cart: current_user.cart)
    if @existing_item
        current_quantity = @existing_item.quantity
        @existing_item.update!(quantity: current_quantity + cart_item_params[:quantity].to_i)
        render json: @existing_item
    else
        @cart_item = CartItem.new(new_params)

        respond_to do |format|
          if @cart_item.save
            format.html { redirect_to @cart_item, notice: "Cart item was successfully created." }
            format.json { render :show, status: :created, location: @cart_item }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @cart_item.errors, status: :unprocessable_entity }
          end
        end
    end
  end

  # PATCH/PUT /cart_items/1 or /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: "Cart item was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1 or /cart_items/1.json
  def destroy
    if @cart_item.cart.user == current_user
      @cart_item.destroy
      respond_to do |format|
        format.html { redirect_to cart_items_url, notice: "Cart item was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_items_url, status: :unprocessable_entity }
        format.json { render json: {message:"Something went wrong."}, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity, :id)
    end
end
