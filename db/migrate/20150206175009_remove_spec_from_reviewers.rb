class RemoveSpecFromReviewers < ActiveRecord::Migration
  def change
    remove_column :reviewers, :spec, :integer
  end
end
