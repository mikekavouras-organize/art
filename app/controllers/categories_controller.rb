class CategoriesController < ApplicationController
  def index
  end

  def show
    render "categories/show", locals: {
      category: category,
      assets: assets
    }
  end

  private

  def category
    @category ||= Category.includes(pieces: { assets_attachments: :blob })
      .find_by(slug: params[:slug])
  end

  def assets
    category.pieces.map(&:assets).flatten
  end
end
