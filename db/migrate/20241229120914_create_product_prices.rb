class CreateProductPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :product_prices, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.boolean :latest, default: true, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false

      t.timestamps
    end
    add_index :product_prices, :product_id, unique: true, where: "latest",
              name:  "index_product_prices_on_product_id_and_latest_true"
    add_check_constraint :product_prices, "amount > 0", name: "non_negative_or_zero_product_price"
  end
end
