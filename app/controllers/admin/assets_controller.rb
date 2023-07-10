module Admin
  class AssetsController < ApplicationController
    before_action :authenticate

    layout "admin"

    def edit
      render "admin/assets/edit", locals: {
        asset: asset,
        category: category,
        series: series
      }
    end

    def update
      asset.update(asset_params)
      flash[:notice] = "Media updated"
      redirect_to edit_admin_category_series_path(category, series)
    end

    private

    def asset
      ActiveStorage::Attachment.find(params[:id])
    end

    def category
      @category ||= Category.find_by(slug: params[:category_slug])
    end

    def series
      @series ||= ::Series.find(params[:series_id])
    end

    def asset_params
      params.require(:attachment).permit(:title, :description)
    end
  end
end
