module FormHelper
  def form_with(options)
    options[:local] = true
    super options
  end
end
