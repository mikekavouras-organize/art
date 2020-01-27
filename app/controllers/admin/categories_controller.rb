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
      Category.create(category_params)
      redirect_to admin_root_path
    end

    def edit
      render "admin/categories/edit", locals: {
        category: category
      }
    end

    def update
      category.update(category_params)
      redirect_to admin_category_path(category)
    end

    def destroy
      category.destroy
      redirect_to admin_root_path
    end

    private

    def category
      @category ||= Category.includes(pieces: { assets_attachments: :blob })
        .find_by(name: params[:name])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end

