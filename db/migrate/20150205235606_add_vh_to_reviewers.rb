class AddVhToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :vh, :integer
  end
end
