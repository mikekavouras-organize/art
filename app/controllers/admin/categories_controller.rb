module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate

    layout "admin"

    def show
      render "admin/categories/show", locals: {
        category: category
      }
    end

    def new
      render "admin/categories/new", locals: {
        category: Category.new
      }
    end

    def create
      category_params = params.require(:category).permit(:name)
      @category =  Category.new(category_params)
      @category.save
      redirect_to admin_category_path(category)
    end

    private

    def category
      @category ||= Category.includes(pieces: { assets_attachments: :blob })
        .find_by(name: params[:name])
    end
  end
end

