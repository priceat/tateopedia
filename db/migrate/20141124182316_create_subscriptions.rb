class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user
      t.belongs_to :plan
      t.string :email
      t.string :stripe_customer_token

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :plan_id
  end
end
