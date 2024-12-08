class CreateProductCategoryPropertyOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :product_category_property_options, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.references :category_property_option, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :product_category_property_options, [ :product_id, :category_property_option_id ],
              unique: true
  end
end
