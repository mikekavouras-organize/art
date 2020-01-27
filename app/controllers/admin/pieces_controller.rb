module Admin
  class PiecesController < ApplicationController
    before_action :authenticate

    layout "admin"

    def new
      render "admin/pieces/new", locals: {
        piece: Piece.new,
        category: category
      }
    end

    def create
      category.pieces.create!(piece_params)
      redirect_to admin_category_path(category)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to admin_category_path(category)
    end

    def edit
      render "admin/pieces/edit", locals: {
        piece: piece,
        assets: assets,
        category: category
      }
    end

    def update
      piece.update!(piece_params)
      redirect_to admin_category_path(category)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to admin_category_path(category)
    end

    def update_assets
      Admin::Piece::UpdateAttachments.call(
        piece: piece, 
        attachables: asset_params.delete("assets"),
        preferred_order: asset_params.delete("ordered_ids").split(",")
      )

      render partial: "admin/pieces/media", locals: {
        model: piece,
        assets: assets
      }
    end

    private

    def category
      @category ||= Category.find_by(name: params[:category_name])
    end

    def piece
      @piece ||= ::Piece.find(params[:id])
    end

    def assets
      @assets ||= piece.ordered_assets
    end

    def piece_params
      @piece_params ||= params.require(:piece).permit(:title, :description)
    end

    def asset_params
      @update_assets_params ||= params.require(:piece).permit(:ordered_ids, assets: [])
    end
  end
end

