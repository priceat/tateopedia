class Subscription < ActiveRecord::Base
  attr_accessor :stripe_card_token
  
  belongs_to :user
  belongs_to :plan
  validates_presence_of :plan_id
  validates_presence_of :email

  attr_accessible :email, :stripe_customer_token, :stripe_card_token, :plan_id

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description:email,
        plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
