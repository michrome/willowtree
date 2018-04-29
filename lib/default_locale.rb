require "contentful"

class DefaultLocale < Middleman::Extension
  expose_to_template :locale

  def initialize(app, options_hash = {}, &block)
    super
    client = Contentful::Client.new(
      space: ENV["CONTENTFUL_SPACE"],
      access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
    )
    @default_locale = client.space.locales.find { |e| e.default == true }.code
    puts "Default locale is #{@default_locale}"
  end

  def locale
    @default_locale
  end
end

::Middleman::Extensions.register(:default_locale, DefaultLocale)
