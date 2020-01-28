class Category < ApplicationRecord
  has_many :collections
  has_many :pieces

  before_save :downcase_name

  validates_length_of :name, :minimum => 1

  def to_param
    name
  end

  def downcase_name
    self.name.downcase!
  end
end
