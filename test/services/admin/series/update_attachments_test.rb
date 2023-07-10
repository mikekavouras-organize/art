require 'test_helper'
require 'dotenv/load'
include ActionDispatch::TestProcess

class Admin::Series::UpdateAttachmentsTest < ActiveSupport::TestCase
  test "adds attachments" do
    series = create(:series)
    refute_predicate series.assets, :attached?

    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    Admin::Series::UpdateAttachments.call(
      series: series,
      attachables: [file],
      preferred_order: []
    )

    series.reload
    assert_predicate series.assets, :attached?
  end

  test "sets initial position when there are no other attachments" do
    series = create(:series)
    refute_predicate series.assets, :attached?

    update_attachments(series, generate_attachments(3))

    assets = series.reload.assets
    assert_equal 0, assets[0].position
    assert_equal 1, assets[1].position
    assert_equal 2, assets[2].position
  end

  test "sets initial position when there are other attachments" do
    series = create(:series)
    refute_predicate series.assets, :attached?
    initial_attachments = generate_attachments(2)
    update_attachments(series, initial_attachments)
    assert_equal 2, series.reload.assets.size

    first, second = generate_attachments(2)
    update_attachments(series, initial_attachments + [first, second])

    assets = series.reload.assets
    assert_equal 2, assets[2].position
    assert_equal 3, assets[3].position
  end

  test "sets the position based on preferred_order" do
    series = create(:series)
    update_attachments(series, generate_attachments(4))

    assets = series.reload.assets
    assert_equal 0, assets[0].position
    assert_equal 1, assets[1].position
    assert_equal 2, assets[2].position
    assert_equal 3, assets[3].position


    ids = series.reload.assets.map(&:signed_id)
    preferred_order = [
      assets[2].id,
      assets[0].id,
      assets[1].id,
      assets[3].id
    ]

    update_attachments(series, ids, preferred_order)

    assert_equal 0, assets[2].position, "Expected asset #{assets[2].id} in position 0"
    assert_equal 1, assets[0].position, "Expected asset #{assets[0].id} in position 1"
    assert_equal 2, assets[1].position, "Expected asset #{assets[1].id} in position 2"
    assert_equal 3, assets[3].position, "Expected asset #{assets[3].id} in position 3"
  end

  def update_attachments(series, attachables, preferred_order = [])
    Admin::Series::UpdateAttachments.call(
      series: series,
      attachables: attachables,
      preferred_order: preferred_order
    )
  end

  def generate_attachments(num)
    (0...num).map do |i|
      fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    end
  end
end
