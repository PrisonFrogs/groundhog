class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :subscriber_id

      t.timestamps
    end
    add_index :subscriptions, %i[user_id subscriber_id], unique: true
  end
end
