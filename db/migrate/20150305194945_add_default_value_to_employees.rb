class AddDefaultValueToEmployees < ActiveRecord::Migration
  def change
    change_column :employees, :position, :string, :default => "No position"
  end
end
