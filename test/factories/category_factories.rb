FactoryBot.define do
  factory :category do
    transient do
      pieces { 0 }
    end
    name { Faker::Name.name }

    after(:build) do |category, evaluator|
      evaluator.pieces.times do
        create(:piece, category: category)
      end
    end
  end
end
