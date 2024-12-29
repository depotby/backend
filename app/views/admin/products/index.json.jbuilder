json.items do
  json.array! @products, partial: "product", as: :product
end
json.partial! "common/pagination", pagination: @pagination
