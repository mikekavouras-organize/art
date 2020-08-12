# frozen_string_literal: true

module Admin
  class ResumesController < ApplicationController
    def create
      Resume.create(attachment: params[:resume])
      redirect_to admin_root_path, flash: { notice: "Artist info updated" }
    end
  end
end
