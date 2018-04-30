module ImageHelpers
  def local_img(url)
    uri = URI.parse(url)
    "images#{uri.path}"
  end
end
