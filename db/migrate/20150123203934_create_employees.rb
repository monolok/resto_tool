class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
    	t.string :name
    	t.string :position
    	t.integer :result


      t.timestamps null: false
    end
  end
end
