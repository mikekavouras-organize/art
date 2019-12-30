FactoryBot.define do
  factory :user do
    factory :valid_user do
      username { ::User::WHITELISTED_USERNAMES.first }
      password { "password" }
    end

    factory :invalid_user do
      username { "bad_username" }
      password { "password" }
    end
  end
end
