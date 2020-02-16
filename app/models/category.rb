class Category < ApplicationRecord
  has_many :collections
  has_many :pieces, -> { order("created_at desc") }, dependent: :destroy

  before_save :set_slug

  validates :name, presence: true

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = self.name.parameterize
  end
end
