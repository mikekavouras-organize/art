class CategoriesController < ApplicationController
  def index
  end

  def show
    first_asset = category.pieces.first.assets.first
    render "categories/show", locals: { category: category, first_asset: first_asset }
  end

  private

  def category
    @category ||= Category.includes(pieces: { assets_attachments: :blob })
      .find_by(slug: params[:slug])
  end
end
