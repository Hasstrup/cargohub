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
    function { rand(1..6).to_s }
    country
  end
end
