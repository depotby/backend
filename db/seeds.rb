def perform_stage(stage_name)
  puts "Starting: #{stage_name}"
  yield if block_given?
  puts "   DONE"
end

puts "Seeding database..."

ActiveRecord::Base.transaction do
  perform_stage "Creating abilities" do
    abilities = Ability.available.map { |name| { name: } }
    Ability.create(abilities)
  end

  super_administrator_role_name = "Super Administrator"

  perform_stage "Creating \"#{super_administrator_role_name}\" role with all abilities" do
    role = Role.create!(name: super_administrator_role_name)
    role.abilities << Ability.all
  end

  test_users = 1000

  perform_stage "Creating #{test_users} test users" do
    users = test_users.times.map do
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        middle_name: [ nil, Faker::Name.middle_name ].sample,
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password,
        account_type: %i[regular employee].sample
      }
    end

    User.create!(users)
  end

  admin_email = "admin@test.dev"
  admin_password = "qwerty123456"

  perform_stage "Creating admin user (email: #{admin_email}, password: #{admin_password})" do
    user = User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                middle_name: Faker::Name.middle_name,
                email: admin_email,
                password: admin_password,
                account_type: :employee)

    user.roles << Role.find_by(name: super_administrator_role_name)
  end
end

puts "Seeding completed successfully!"
