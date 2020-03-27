# frozen_string_literal: true

module Admin
  class SeriesController < ApplicationController
    before_action :authenticate

    layout "admin"

    def new
      render "admin/series/new", locals: {
        series: ::Series.new,
        category: category
      }
    end

    def create
      series = category.series.create!(series_params)
      flash[:success] = "\"#{series.title}\" was created"
      redirect_to edit_admin_category_series_path(category, series)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to new_admin_category_series_path(category)
    end

    def edit
      render "admin/series/edit", locals: {
        series: series,
        assets: assets,
        category: category
      }
    end

    def update
      series.update!(series_params)
      flash[:success] = "\"#{series.title}\" was updated"
      redirect_to admin_category_path(category)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to admin_category_path(category)
    end

    def update_assets
      Admin::Series::UpdateAttachments.call(
        series: series, 
        attachables: asset_params.delete("assets"),
        preferred_order: asset_params.delete("ordered_ids").split(",")
      )

      render partial: "admin/series/media", locals: {
        model: series,
        assets: assets
      }
    end

    def delete_asset
      asset.purge
      redirect_to edit_admin_category_series_path(category, series)
    end

    private

    def category
      @category ||= Category.find_by(slug: params[:category_slug])
    end

    def series
      @series ||= ::Series.find(params[:id])
    end

    def assets
      @assets ||= series.ordered_assets
    end

    def asset
      @asset ||= ActiveStorage::Attachment.find(params[:asset_id])
    end

    def series_params
      @series_params ||= params.require(:series).permit(:title, :description)
    end

    def asset_params
      @update_assets_params ||= params.require(:series).permit(:ordered_ids, assets: [])
    end
  end
end

