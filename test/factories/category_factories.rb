FactoryBot.define do
  factory :category do
    transient do
      series { 0 }
    end
    name { Faker::Name.name }

    after(:build) do |category, evaluator|
      evaluator.series.times do
        create(:series, category: category)
      end
    end
  end
end
