class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin, default: false
      t.string :password_digest
      t.string :remember_digest, null: true
      t.string :activation_digest, null: true
      t.boolean :activated, default: true
      t.datetime :activated_at, null: true
      t.string :reset_digest, null: true
      t.datetime :reset_send_at, null: true

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
