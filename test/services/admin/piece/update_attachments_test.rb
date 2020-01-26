require 'test_helper'
require 'dotenv/load'
include ActionDispatch::TestProcess

class Admin::Piece::UpdateAttachmentsTest < ActiveSupport::TestCase
  test "adds attachments" do
    piece = create(:piece)
    refute_predicate piece.assets, :attached?

    file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    Admin::Piece::UpdateAttachments.call(
      piece: piece,
      attachables: [file],
      preferred_order: []
    )

    piece.reload
    assert_predicate piece.assets, :attached?
  end

  test "sets initial position when there are no other attachments" do
    piece = create(:piece)
    refute_predicate piece.assets, :attached?

    update_attachments(piece, generate_attachments(3))

    assets = piece.reload.assets
    assert_equal 0, assets[0].position
    assert_equal 1, assets[1].position
    assert_equal 2, assets[2].position
  end

  test "sets initial position when there are other attachments" do
    piece = create(:piece)
    refute_predicate piece.assets, :attached?
    initial_attachments = generate_attachments(2)
    update_attachments(piece, initial_attachments)
    assert_equal 2, piece.reload.assets.size

    first, second = generate_attachments(2)
    update_attachments(piece, initial_attachments + [first, second])

    assets = piece.reload.assets
    assert_equal 2, assets[2].position
    assert_equal 3, assets[3].position
  end

  test "sets the position based on preferred_order" do
    piece = create(:piece)
    update_attachments(piece, generate_attachments(4))

    assets = piece.reload.assets
    assert_equal 0, assets[0].position
    assert_equal 1, assets[1].position
    assert_equal 2, assets[2].position
    assert_equal 3, assets[3].position

    ids = piece.reload.assets.map(&:signed_id)
    preferred_order = [
      assets[2].id,
      assets[0].id,
      assets[1].id,
      assets[3].id
    ]
    update_attachments(piece, ids, preferred_order)

    assets = piece.reload.assets
    assert_equal 0, assets[2].position
    assert_equal 1, assets[0].position
    assert_equal 2, assets[1].position
    assert_equal 3, assets[3].position
  end

  def update_attachments(piece, attachables, preferred_order = [])
    Admin::Piece::UpdateAttachments.call(
      piece: piece,
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
