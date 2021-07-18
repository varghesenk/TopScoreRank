# spec/factories/scores.rb
FactoryBot.define do
  factory :score do
    score { Faker::Number.between(from: 1, to: 10)}
    created_at {Faker::Time.between(from: 2.days.ago, to: Time.now) }
    player_id {nil}
  end
end
