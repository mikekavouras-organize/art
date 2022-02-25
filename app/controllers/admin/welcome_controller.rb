module Admin
  class WelcomeController < ApplicationController
    before_action :authenticate

    layout "admin"

    def index
      render "admin/welcome/index", locals: {
        categories: Category.all.order(position: :asc),
        info: ArtistInfo.last || ArtistInfo.new,
        resume: Resume.last,
      }
    end

    def update_category_positions
      category_ids = params.delete("positions").split(",")

      puts "*" * 80
      puts category_ids
      puts "*" * 80

      case_string = "position = CASE id "
      category_ids.each.with_index do |id, index|
        case_string += "WHEN #{id} THEN #{index} "
      end
      case_string += "END"

      Category.where(id: category_ids).update_all(case_string)
    end
  end
end


