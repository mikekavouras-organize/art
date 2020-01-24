class Category < ApplicationRecord
  has_many :collections
  has_many :pieces

  before_save :downcase_name

  def to_param
    name
  end

  def downcase_name
    self.name.downcase!
  end
end
