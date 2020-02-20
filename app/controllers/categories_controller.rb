class CategoriesController < ApplicationController
  def index
  end

  def show
    render "categories/show", locals: { category: category }
  end

  private

  def category
    @category ||= Category.includes(pieces: { assets_attachments: :blob })
      .find_by(slug: params[:slug])
  end
end
