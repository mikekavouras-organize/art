# frozen_string_literal: true

module Admin
  class ArtistInfosController < ApplicationController
    before_action :authenticate

    def create
      ArtistInfo.create(bio: params[:artist_info][:bio])
      redirect_to admin_root_path, flash: { notice: "Artist info updated" }
    end

    def update
      artist_info.update(bio: params[:artist_info][:bio])
      redirect_to admin_root_path, flash: { notice: "Artist info updated" }
    end

    private

    def artist_info
      ArtistInfo.find(params[:id])
    end

    def artist_info_params
      params.require(:artist_info).permit(:bio)
    end
  end
end

