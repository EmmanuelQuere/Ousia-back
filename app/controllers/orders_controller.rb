class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create_payment
    cart_id = params[:id].to_i
    @total = Cart.find(cart_id).total
    @user = current_user
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer_email: @user.email,
      line_items: [
        {
          name: "Ousia",
          amount: (@total * 100).to_i + 1000,
          currency: "eur",
          quantity: 1,
        },
      ],
      success_url: ENV['STRIPE_REDIRECT_URL'] + "/cart/recap?success=true&session_id={CHECKOUT_SESSION_ID}&cart_id=#{cart_id}",
      cancel_url: ENV['STRIPE_REDIRECT_URL'] + '/cart/recap?canceled=true',
    )
    render json: { id: @session.id  }
  end

  def create
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    payment_id = @payment_intent.id
    if Order.find_by(stripe_id:payment_id)
      return render json: { order: Order.find_by(stripe_id:payment_id), status: :existing  }
    else
      @order = Order.create!(user:current_user, stripe_id: payment_id, status:"confirmed")
      @cart = Cart.find(params[:cart_id])
      @cart.cart_items.each do |cart_item|
        OrderItem.create!(order:@order, item:cart_item.item, quantity: cart_item.quantity)
      end
      @cart.cart_items.destroy_all
      render json: { order: @order, status: :created  }
    end
  end
end
