class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :color
      t.integer :win
      t.integer :lost
      t.string :password_digest

      t.timestamps
    end
  end
end
