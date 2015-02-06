class RemovePermitFromReviewers < ActiveRecord::Migration
  def change
    remove_column :reviewers, :permit, :text
  end
end
