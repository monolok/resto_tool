class RemoveRoleFromReviewers < ActiveRecord::Migration
  def change
    remove_column :reviewers, :role, :string
  end
end
