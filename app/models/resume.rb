# frozen_string_literal: true

class Resume < ApplicationRecord
  has_one_attached :attachment
end
