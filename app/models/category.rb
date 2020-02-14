class Category < ApplicationRecord
  has_many :collections
  has_many :pieces, dependent: :destroy

  before_save :downcase_name

  validates :name, presence: true

  def to_param
    name
  end

  def downcase_name
    self.name.downcase!
  end
end
