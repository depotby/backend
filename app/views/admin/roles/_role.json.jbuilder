json.extract! role, :id, :name, :created_at, :updated_at

if abilities
  json.abilities role.abilities.pluck(:name)
end
