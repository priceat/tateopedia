class CreateCharge

  def self.call(user, params)
    if @customer = create_customer
      charge_customer
      user.update(role: 'premium', stripe_customer_id: @customer.id)
    end
  end

  private

  def self.create_customer
    Stripe::Customer.create(
      email:    user.email,
      card:     params[:stripeToken]
    )
  end

  def self.charge_customer
    Stripe::Charge.create(
      customer:     @customer.id,
      amount:       params[:amount],
      description:  "Membership - #{user.email}",
      currency:     'usd'
      )
  end
    
end  
  