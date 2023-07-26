# frozen_string_literal: true

module Admin
  class ArtistStatementController < ::AdminController
    def create
      artist_info.update(artist_statement: params[:artist_statement])
      redirect_to admin_root_path(tab: "statement"), flash: { notice: "Artist statement updated." }
    end

    def destroy
      artist_info.artist_statement.destroy
      redirect_to admin_root_path(tab: "statement"), flash: { notice: "Artist statement removed" }
    end

    private

    def artist_info
      @info ||= (ArtistInfo.last || ArtistInfo.new)
    end
  end
end
