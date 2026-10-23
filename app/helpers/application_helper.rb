module ApplicationHelper
  def render_markdown(text)
    markdown_renderer.render(text).html_safe
  end

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  # MIME type to advertise in a <video><source type="...">.
  #
  # Chrome, Firefox and Edge report canPlayType("video/quicktime") == "" and
  # skip the source entirely, even though our .mov files are H.264 in an
  # ISO-BMFF container that they decode fine as MP4. Safari plays either way.
  def video_source_type(content_type)
    content_type == "video/quicktime" ? "video/mp4" : content_type
  end
end
