json.items do
  json.array! @roles, partial: "role", as: :role, abilities: false
end
json.partial! "common/pagination", items: @roles, pagination: @pagination
