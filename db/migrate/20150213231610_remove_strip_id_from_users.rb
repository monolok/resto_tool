class RemoveStripIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :strip_id, :string
  end
end
