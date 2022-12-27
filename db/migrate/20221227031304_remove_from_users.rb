class RemoveFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_table(:users) do |t|
      t.remove :color
      t.remove :win
      t.remove :lost
      t.remove :current_game
      t.remove :capital
    end
  end
end
