class AddVlToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :vl, :integer
  end
end
