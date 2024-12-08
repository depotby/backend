class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :account_type, null: false, default: User.account_types[:regular]

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
