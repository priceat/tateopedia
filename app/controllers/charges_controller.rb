class ChargesController < ApplicationController

 def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     email: current_user.email,
     description: "Tateopedia Membership - #{current_user.name}",
     amount: 25 
    }
  end

  def create
    @amount = params[:amount]
    
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    begin
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @amount,
        description: "CashMoney Membership - #{current_user.email}",
        currency: 'usd'
        )

      if current_user.update(premium: true)
        flash[:success] = "You're paid up, #{current_user.email}! Thanks for the lettuce doggy!"
        redirect_to edit_user_registration_path
      else
        flash[:success] = "There was an error upgrading your account. Please contact support!"
        redirect_to edit_user_registration_path
      end


    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    end
  end




end