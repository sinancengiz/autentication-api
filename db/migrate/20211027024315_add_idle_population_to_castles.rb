class AddIdlePopulationToCastles < ActiveRecord::Migration[6.1]
  def change
    add_column :castles, :idle_population, :integer
  end
end
