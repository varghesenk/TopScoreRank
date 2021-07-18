class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.datetime :created_at

      #t.timestamps
    end
  end
end
