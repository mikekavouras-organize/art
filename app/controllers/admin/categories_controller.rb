module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate
    before_action :category_required, only: [:show, :edit, :update]

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
      if params["delete"]
        destroy
      elsif params["cancel"]
        redirect_to admin_category_path(category)
      else
        category.update(category_params)
        redirect_to admin_category_path(category)
      end
    end

    def destroy
      name = category.name
      category.destroy
      flash[:error] = "Deleted #{name}"
      redirect_to admin_root_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def category
      @category ||= Category.includes(pieces: { assets_attachments: :blob })
        .find_by(slug: params[:slug])
    end

    def category_required
      unless category
        redirect_to admin_root_path, flash: { error: "Category not found" }
      end
    end
  end
end

