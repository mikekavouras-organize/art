module Admin
  class PiecesController < ApplicationController
    layout "admin"

    def show
      @piece = Piece.find(params[:id])
    end

    def new
      @piece = Piece.new
    end

    def create
      category.pieces.create!(piece_params)
      redirect_to admin_category_path(category)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to admin_category_path(category)
    end

    def edit
      @piece = Piece.find(params[:id])
    end

    def update
      piece.update!(piece_params)
      redirect_to admin_category_path(category)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to admin_category_path(category)
    end

    private

    def category
      @category ||= Category.find_by(name: params[:category_name])
    end
    helper_method :category

    def piece
      @piece ||= Piece.find(params[:id])
    end

    def piece_params
      params.require(:piece).permit(:title, :description, assets: [])
    end
  end
end

