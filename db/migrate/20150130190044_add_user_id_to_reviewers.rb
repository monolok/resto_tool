class AddUserIdToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :user_id, :integer
  end
end
