# frozen_string_literal: true

module Admin
  class ResumesController < ::AdminController
    def create
      Resume.create(attachment: params[:resume])
      redirect_to admin_root_path(tab: "resume"), flash: { notice: "Artist info updated" }
    end

    def destroy
      Resume.last.destroy
      redirect_to admin_root_path(tab: "resume"), flash: { notice: "CV deleted" }
    end
  end
end
