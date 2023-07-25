require 'test_helper'

class Admin::ArtistInfosControllerTest < TestBase
  setup do
    @user = create(:valid_user)
  end

  test "POST#create creates a new record with the provided bio" do
    as @user
    post admin_artist_infos_path, params: {
      artist_info: {
        bio: "new bio"
      }
    }
    assert_redirected_to admin_root_path
    assert_equal ArtistInfo.count, 1

    artist_info = ArtistInfo.last
    assert_equal artist_info.bio, "new bio"
  end

  test "PATCH#update updates the existing bio" do
    ArtistInfo.create(bio: "old bio")
    assert_equal ArtistInfo.count, 1
    assert_equal ArtistInfo.last.bio, "old bio"

    as @user
    patch admin_artist_info_path(id: ArtistInfo.last.id), params: {
      artist_info: {
        bio: "new bio"
      }
    }

    assert_equal 1, ArtistInfo.count
    assert_equal "new bio", ArtistInfo.last.bio
  end
end
