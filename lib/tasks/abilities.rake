namespace :abilities do
  desc "Sync abilities in database"
  task sync: :environment do
    Ability.where.not(name: Ability.available).destroy_all

    Ability.available.each do |name|
      Ability.find_or_create_by(name:)
    end
  end
end
