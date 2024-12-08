json.items do
  json.array! @users, partial: "user", as: :user, roles: false
end
json.partial! "common/pagination", items: @users, pagination: @pagination
