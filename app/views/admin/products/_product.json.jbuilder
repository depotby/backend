json.extract! product, :id, :category_id, :name, :uri_name, :created_at, :updated_at

json.product_price do
  json.partial! "admin/product_prices/product_price", product_price: product.latest_product_price
end
