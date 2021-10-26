class CreateJoinTableCastlesGames < ActiveRecord::Migration[6.1]
  def change
    create_join_table :games, :castles do |t|
      # t.index [:game_id, :castle_id]
      # t.index [:castle_id, :game_id]
    end
  end
end
