class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :nickname, null: false
      t.string :password_digest, null: false
      t.string :bio, null: false
      t.integer :gender, default: 0
      t.integer :age
      t.string :location
      t.timestamps
    end
  end
end
