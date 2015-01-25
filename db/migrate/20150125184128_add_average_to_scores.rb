class AddAverageToScores < ActiveRecord::Migration
  def change
    add_column :scores, :average, :decimal, :precision => 16, :scale => 2
  end
end
