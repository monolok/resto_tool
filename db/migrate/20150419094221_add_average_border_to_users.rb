class AddAverageBorderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :average_border, :float, :default => 2.5
  end
end
