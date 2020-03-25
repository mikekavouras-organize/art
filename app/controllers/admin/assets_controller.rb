module Admin
  class AssetsController < ApplicationController
    layout "admin"

    def edit
      render "admin/assets/edit", locals: {
        asset: asset,
        category: category,
        piece: piece
      }
    end

    def update
      asset.update(asset_params)
      flash[:notice] = "Media updated"
      redirect_to edit_admin_category_piece_path(category, piece)
    end

    private

    def asset
      ActiveStorage::Attachment.find(params[:id])
    end

    def category
      @category ||= Category.find_by(slug: params[:category_slug])
    end

    def piece
      @piece ||= ::Piece.find(params[:piece_id])
    end

    def asset_params
      params.require(:attachment).permit(:title, :description)
    end
  end
end
