class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :role
      t.boolean :super_user
      t.string :phone_number
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
  end
end
