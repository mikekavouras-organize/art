module Admin
  class WelcomeController < ApplicationController
    before_action :authenticate

    layout "admin"

    def index
      render "admin/welcome/index", locals: {
        categories: categories,
        info: artist_info,
        headshot: artist_info.headshot,
        resume: resume,
        resume_preview: resume_preview,
      }
    end

    def update_category_positions
      category_ids = params.delete("positions").split(",")

      sql = "position = CASE id "
      category_ids.each.with_index do |id, index|
        sql += "WHEN #{id} THEN #{index} "
      end
      sql += "END"

      Category.where(id: category_ids).update_all(sql)
    end

    private

    def artist_info
      @info ||= ArtistInfo.last || ArtistInfo.new
    end

    def categories
      Category.all.order(position: :asc)
    end

    def resume
      @resume ||= Resume.last
    end

    def resume_preview
      resume.attachment.preview(resize_to_limit: [640, 640])
    rescue
      nil
    end
  end
end


