class RemoveStripeIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :stripe_id, :integer
    add_column :users, :stripe_id, :string
  end
end
