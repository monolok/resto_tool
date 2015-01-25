class AddEmployeeIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :employee_id, :integer
  end
end
