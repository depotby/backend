class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: :uuid do |t|
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :uri_name

      t.timestamps
    end
    add_index :products, :uri_name, unique: true
  end
end
