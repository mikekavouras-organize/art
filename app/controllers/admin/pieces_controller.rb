module Admin
  class PiecesController < ApplicationController
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
        category: category
      }
    end

    def update
      ordered_ids = piece_params.delete("ordered_ids").split(",")
      piece.assign_attributes(piece_params)
      piece.update_media_positions(ordered_ids)
      piece.save!
      if request.xhr?
        render partial: "admin/pieces/media", locals: {
          model: piece
        }
      else
        redirect_to admin_category_path(category)
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to admin_category_path(category)
    end

    private

    def category
      @category ||= Category.find_by(name: params[:category_name])
    end

    def piece
      @piece ||= Piece.with_attached_assets.find(params[:id])
    end

    def piece_params
      @piece_params ||= params.require(:piece).permit(:title, :description, :ordered_ids, assets: [])
    end
  end
end

