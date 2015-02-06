class AddHToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :h, :integer
  end
end
