module Admin
  module Series
    class UpdateAttachments
      # Public: update the attachables on an existing series
      #
      # series: The Series object to update
      # attachables: A list of strings (ActiveStorage::Attachment#signed_id)
      #              representing an attachable
      # preferred_order: A list of asset ids in the desired order
      def self.call(series:, attachables:, preferred_order:)
        new(
          series: series,
          attachables: attachables,
          preferred_order: preferred_order
        ).call
      end

      def initialize(series:, attachables:, preferred_order:)
        @series = series
        @attachables = attachables
        @preferred_order = preferred_order
      end

      def call
        series.assign_attributes(assets: attachables)
        if new_attachments?
          assign_positions
        else
          update_positions
        end
        series.save!
      end

      private

      attr_accessor :series, :attachables, :preferred_order

      def assign_positions
        existing_assets, new_assets = assets.partition(&:persisted?)
        highest_current_position = if existing_assets.any?
          existing_assets.sort_by(&:position).last.position + 1
        else
          0
        end
        new_assets.each_with_index do |new_asset, index|
          new_asset.position = highest_current_position + index
        end
      end

      def update_positions
        ActiveStorage::Attachment.transaction do
          preferred_order.each_with_index do |id, index|
            asset = assets.find { |asset| asset.id == id.to_i }
            asset.position = index
            asset.save
          end
        end
      end

      def assets
        @assets ||= series.assets
      end

      def new_attachments?
        attachables.any? { |attachable| attachable.is_a?(attachable_class) }
      end

      def attachable_class
        if Rails.env.test?
          Rack::Test::UploadedFile
        else
          ActionDispatch::Http::UploadedFile
        end
      end
    end
  end
end
