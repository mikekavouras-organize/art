FactoryBot.define do
  factory :piece do
    title { Faker::Creature::Animal.name }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    category { create(:category) }
  end
end
