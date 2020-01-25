module Admin
  class CategoriesController < ApplicationController
    def show
      @pieces = category.pieces.with_attached_assets
    end

    private

    def category
      @category ||= Category.find_by(name: params[:name])
    end
    helper_method :category
  end
end

