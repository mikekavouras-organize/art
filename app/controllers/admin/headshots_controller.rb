# frozen_string_literal: true

module Admin
  class HeadshotsController < ::AdminController
    def create
      artist_info.update(headshot: params[:headshot])
      redirect_to admin_root_path, flash: { notice: "Artist photo updated" }
    end

    def destroy
      artist_info.headshot&.destroy
      redirect_to admin_root_path, flash: { notice: "Removed artist photo" }
    end

    private

    def artist_info
      @info ||= (ArtistInfo.last || ArtistInfo.create)
    end
  end
end
