class Category < ApplicationRecord
  has_many :collections
  has_many :pieces, dependent: :destroy

  before_save :downcase_name
  before_save :set_slug

  validates :name, presence: true

  def to_param
    slug
  end

  private

  def downcase_name
    self.name.downcase!
  end

  private

  def set_slug
    self.slug = self.name.parameterize
  end
end
