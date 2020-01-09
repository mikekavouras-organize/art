class Category < ApplicationRecord
    has_many :collections
    has_many :pieces
end
