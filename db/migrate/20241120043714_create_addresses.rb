class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.string :region, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.string :street, null: false
      t.string :building, null: false
      t.string :building_section
      t.string :apartment

      t.timestamps
    end

    add_index :addresses, [ :user_id, :name ], unique: true
  end
end
