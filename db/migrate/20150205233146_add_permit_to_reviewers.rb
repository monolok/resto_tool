class AddPermitToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :permit, :text
  end
end
