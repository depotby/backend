json.extract! category_property, :id, :category_id, :name, :uri_name, :created_at, :updated_at

json.options do
  json.array! category_property.category_property_options,
              partial: "admin/category_property_options/category_property_option",
              as: :category_property_option
end
