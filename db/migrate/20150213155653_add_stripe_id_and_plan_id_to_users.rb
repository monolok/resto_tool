class AddStripeIdAndPlanIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plan_id, :integer
    add_column :users, :stripe_id, :integer
  end
end
