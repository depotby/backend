json.items do
  json.array! @categories, partial: "category", as: :category
end
json.partial! "common/pagination", pagination: @pagination
