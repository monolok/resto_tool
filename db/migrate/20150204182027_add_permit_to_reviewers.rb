class AddPermitToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :permit, :integer
  end
end
