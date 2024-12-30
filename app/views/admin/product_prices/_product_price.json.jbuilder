if product_price
  json.extract! product_price, :id, :product_id, :amount, :created_at, :updated_at
else
  json.null!
end
