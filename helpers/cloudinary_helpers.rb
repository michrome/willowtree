module CloudinaryHelpers
  def cloudinary_image_tag(source, options = {})
    cloudinary_cloud_name = ENV["CLOUDINARY_CLOUD_NAME"]
    fetch = "https://res.cloudinary.com/#{cloudinary_cloud_name}/image/fetch/f_auto,q_auto/https:"
    image_tag(fetch + source, options)
  end
end
