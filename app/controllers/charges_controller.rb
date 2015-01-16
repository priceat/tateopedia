class ChargesController < ApplicationController

 def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     email: current_user.email,
     description: "Tateopedia Membership - #{current_user.name}",
     amount: 2500 
    }
  end

  def create
    if CreateCharge.call(current_user, params)
      redirect_to edit_user_registration_path, alert: 'Upgrade successful'
    else
      stripe_card_error
    end
  end

  def destroy
    
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)

    if customer.delete
      current_user.update(stripe_customer_id: 0, role: 'standard')
      current_user.destroy_private_wikis
      flash[:notice] = "You're no longer premium. Welcome back to mediocrity. And all of your private wikis are gone..."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was an error downgrading your account. Please contact support!"
      redirect_to edit_user_registration_path
    end
  end

  private

  def stripe_card_error
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end
  


end