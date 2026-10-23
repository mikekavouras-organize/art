require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "video_source_type advertises QuickTime as MP4 so Chrome/Firefox will play it" do
    assert_equal "video/mp4", video_source_type("video/quicktime")
  end

  test "video_source_type leaves other video types alone" do
    assert_equal "video/mp4", video_source_type("video/mp4")
    assert_equal "video/webm", video_source_type("video/webm")
  end
end
