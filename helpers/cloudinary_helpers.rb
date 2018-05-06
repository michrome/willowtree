module CloudinaryHelpers
  def cloudinary_image_tag(source, options = {})
    image_tag(cloudinary_image_url(source), options)
  end

  def cloudinary_image_url(source)
    cloudinary_cloud_name = ENV["CLOUDINARY_CLOUD_NAME"]
    fetch = "https://res.cloudinary.com/#{cloudinary_cloud_name}/image/fetch/f_auto,q_auto/https:"
    fetch + source
  end
end
