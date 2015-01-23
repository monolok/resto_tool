class AddPomToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :pom, :integer
  end
end
