class CreateCategoryProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :category_properties, id: :uuid do |t|
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.string :uri_name, null: false

      t.timestamps
    end
    add_index :category_properties, :uri_name, unique: true
    add_index :category_properties, [ :category_id, :name ], unique: true
  end
end
