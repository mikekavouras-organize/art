module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate

    layout "admin"

    def show
      render "admin/categories/show", locals: {
        category: category
      }
    end

    private

    def category
      @category ||= Category.includes(pieces: { assets_attachments: :blob })
        .find_by(name: params[:name])
    end
  end
end

