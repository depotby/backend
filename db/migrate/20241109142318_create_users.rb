class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :account_type, null: false, default: User.account_types[:regular]

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
