json.extract! user, :id, :first_name, :last_name, :middle_name, :email, :account_type, :created_at,
              :updated_at

if roles
  json.roles do
    json.array! user.roles, partial: "role", as: :role
  end
end
