class AddArmyToCastles < ActiveRecord::Migration[6.1]
  def change
    add_column :castles, :army, :integer
  end
end
