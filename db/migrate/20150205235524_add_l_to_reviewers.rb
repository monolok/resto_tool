class AddLToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :l, :integer
  end
end
