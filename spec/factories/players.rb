# spec/factories/players.rb
FactoryBot.define do
  factory :player do
    name { Faker::Lorem.word }
  end
end
