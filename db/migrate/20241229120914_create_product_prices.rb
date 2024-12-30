class CreateProductPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :product_prices, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.decimal :amount, precision: 12, scale: 2, null: false

      t.timestamps
    end
    add_check_constraint :product_prices, "amount > 0", name: "non_negative_or_zero_product_price"
  end
end
