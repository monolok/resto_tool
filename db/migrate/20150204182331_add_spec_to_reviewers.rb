class AddSpecToReviewers < ActiveRecord::Migration
  def change
    add_column :reviewers, :spec, :integer
  end
end
