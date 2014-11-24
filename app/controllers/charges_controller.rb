class ChargesController < ApplicationController

  def create
    @amount = params[:amount]
    
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "CashMoney Membership - #{current_user.email}",
      currency: 'usd'
      )

    flash[:success] = "You're paid up, #{current_user.email}! Thanks for the lettuce doggy!"
    redirect_to user_path(current_user)


  rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
  end

 def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     email: current_user.email,
     description: "Tateopedia Membership - #{current_user.name}",
     amount: 2500 
    }
  end


end