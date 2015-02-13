class RemovePlanIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :plan_id, :integer
    add_column :users, :plan_id, :string
  end
end
