class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :created_by
      t.integer :player_count

      t.timestamps
    end
  end
end
