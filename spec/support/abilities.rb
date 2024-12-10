RSpec.configure do |config|
  config.before(:suite) do
    Ability.destroy_all
    Ability.available.each do |name|
      Ability.create(name: name)
    end
  end
end
