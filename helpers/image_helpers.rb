module ImageHelpers
  def contentful_image_path(path)
    path.slice!("//images.ctfassets.net/")
    image_path path
  end
end
