class CreateCategoryPropertyOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :category_property_options, id: :uuid do |t|
      t.references :category_property, null: false, foreign_key: true, type: :uuid
      t.string :variant, null: false

      t.timestamps
    end
    add_index :category_property_options, [ :category_property_id, :variant ], unique: true
  end
end
