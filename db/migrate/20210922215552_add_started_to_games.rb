class AddStartedToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :started, :boolean
  end
end
