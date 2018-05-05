require "lib/grab_images"

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end

activate :contentful do |f|
  f.space = Hash[ENV["CONTENTFUL_SPACE"], ENV["CONTENTFUL_SPACE"]]
  f.access_token = ENV["CONTENTFUL_ACCESS_TOKEN"]
  f.content_types = {diary_dates: "dateForYourDiary", school: "school", articles: "article"}
end

activate :livereload
activate :grab_images
activate :imageoptim

import_file File.expand_path("_headers", config[:source]), "/_headers"

config[:host] = ENV["HOST"] || "http://127.0.0.1:4567"
set :url_root, config[:host]

activate :search_engine_sitemap
