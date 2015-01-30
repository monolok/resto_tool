class AddReviewerIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :reviewer_id, :integer
  end
end
