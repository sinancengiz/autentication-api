class DropCastle < ActiveRecord::Migration[6.1]
  def change
    drop_table :castles
    drop_table :castles_games
    drop_table :games
    drop_table :games_users
  end
end
