require "contentful"
require "open-uri"
client = Contentful::Client.new(
  space: ENV["CONTENTFUL_SPACE"],
  access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
)
client.assets.each do |asset|
  download = open("https:" + asset.image_url)
  directory_and_file = "source/images#{download.base_uri.path}"
  directory = File.dirname(directory_and_file)
  FileUtils.mkdir_p(directory) unless File.exists?(directory)
  IO.copy_stream(download, directory_and_file)
end
puts Dir.pwd