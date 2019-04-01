require 'faker'

FactoryBot.define do
  factory :hub do
    name { Faker::Name.unique.name }
    status { 'RL' }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    sequence :locode do |n|
      "LA #{n}"
    end
    country
  end
end
