FactoryBot.define do
  factory :user do
    password { "password" }

    factory :valid_user do
      username { ::User::WHITELISTED_USERNAMES.first }
    end

    factory :invalid_user do
      username { "bad_username" }
    end
  end
end
