class RemoveResultFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :result, :integer
  end
end
