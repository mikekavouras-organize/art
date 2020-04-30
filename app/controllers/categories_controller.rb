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
    @category ||= Category
      .includes(series: { assets_attachments: :blob })
      .order("series.position asc")
      .find_by(slug: params[:slug])
  end

  def assets
    category.series.map { |s| s.assets.sort_by(&:position) }.flatten
  end
end
