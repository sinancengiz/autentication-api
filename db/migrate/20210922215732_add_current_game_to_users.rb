class AddCurrentGameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_game, :integer
  end
end
