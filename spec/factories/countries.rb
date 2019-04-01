require 'faker'

FactoryBot.define do
  factory :country do
    name { Faker::Address.country }
    symbol { name.slice(0, 2).to_s }
  end
end
