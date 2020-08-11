# frozen_string_literal: true

module Admin
  class ResumesController < ApplicationController
    def create
      Resume.create(attachment: params[:resume])
    end
  end
end
