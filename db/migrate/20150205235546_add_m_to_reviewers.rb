class AddMToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :m, :integer
  end
end
