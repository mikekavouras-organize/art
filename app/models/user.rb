class User < ApplicationRecord
  has_secure_password

  WHITELISTED_USERNAMES = ["mikekavouras", "bennfos", "jennifer"].freeze

  validates :username,
    inclusion: {
      in: WHITELISTED_USERNAMES,
      message: "%{value} is not a valid username" 
    },
    uniqueness: true
end
