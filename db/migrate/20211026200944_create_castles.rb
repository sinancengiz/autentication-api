class CreateCastles < ActiveRecord::Migration[6.1]
  def change
    create_table :castles do |t|
      t.belongs_to :user
      t.string :name
      t.integer :population
      t.integer :gold_worker
      t.integer :farm_worker
      t.integer :wood_worker
      t.integer :stone_worker
      t.integer :iron_worker

      t.timestamps
    end
  end
end
