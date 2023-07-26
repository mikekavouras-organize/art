module Admin
  class WelcomeController < ::AdminController
    before_action :authenticate

    layout "admin"

    def index
      render "admin/welcome/index", locals: {
        categories: Category.all.order(position: :asc),
        info: artist_info,
        headshot: artist_info.headshot,
        resume: resume,
        resume_preview: resume_preview,
        artist_statement: artist_statement,
        artist_statement_preview: artist_statement_preview,
      }
    end

    def update_category_positions
      category_ids = params.delete("positions").split(",")

      case_string = "position = CASE id "
      category_ids.each.with_index do |id, index|
        case_string += "WHEN #{id} THEN #{index} "
      end
      case_string += "END"

      Category.where(id: category_ids).update_all(case_string)
    end

    def artist_info
      @info ||= (ArtistInfo.last || ArtistInfo.new)
    end

    def resume
      return @resume if defined?(@resume)
      @resume = Resume.last
    end

    def resume_preview
      resume&.attachment.preview(resize_to_limit: [640, 640]) rescue nil
    end

    def artist_statement
      artist_info.artist_statement
    end

    def artist_statement_preview
      artist_statement.preview(resize_to_limit: [640, 640]) rescue nil
    end
  end
end


