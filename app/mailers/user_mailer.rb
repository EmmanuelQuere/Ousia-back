class UserMailer < ApplicationMailer
    def welcome_email(user)
        @user = user
        @url = 'https://ousia-front.herokuapp.com'
        mail(to: @user.email, subject: 'Bienvenue chez Ousia') 
      end

      def order_email(order)
        @user = User.find(order.user_id)
        @order = order
        @url = 'https://ousia-front.herokuapp.com'
        mail(to: @user.email, subject: 'Confirmation de votre achat chez Ousia') 
      end
  
  end