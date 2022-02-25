module FormHelper
  def form_with(opts)
    opts[:local] = true
    super(**opts)
  end
end
