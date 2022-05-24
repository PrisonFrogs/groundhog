class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :nick_name
      t.string :password_digest
      t.string :bio
      t.integer :gender
      t.integer :age
      t.string :location

      t.timestamps
    end
  end
end
