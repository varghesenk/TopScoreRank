class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :score
      t.references :player, null: false, foreign_key: true
      t.datetime :created_at
    end
  end
end
