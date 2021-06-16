class UserMailer < ApplicationMailer
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Bienvenue chez Ouisia') 
      end

      def order_email(order)
        @user = User.find(order.user_id)
        @order = order
        mail(to: @user.email, subject: 'Confirmation de votre achat chez Ouisia') 
      end
  
  end