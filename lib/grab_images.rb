require "contentful"
require "open-uri"

class GrabImages < Middleman::Extension
  def initialize(app, options_hash = {}, &block)
    super
  end

  def after_configuration
    client = Contentful::Client.new(
      space: ENV["CONTENTFUL_SPACE"],
      access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
    )
    puts "Grabbing images"
    client.assets.each do |asset|
      download = open("https:" + asset.image_url)
      directory_and_file = "source/images#{download.base_uri.path}"
      directory = File.dirname(directory_and_file)
      FileUtils.mkdir_p(directory) unless File.exists?(directory)
      IO.copy_stream(download, directory_and_file)
    end
  end
end

::Middleman::Extensions.register(:grab_images, GrabImages)
