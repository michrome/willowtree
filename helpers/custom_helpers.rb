require "contentful"

module CustomHelpers
  def locale
    @@locale ||= begin
      puts "Setting locale"
      client = Contentful::Client.new(
        space: ENV["CONTENTFUL_SPACE"],
        access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
      )
      client.space.locales.find { |e| e.default == true }.code
    end
  end

  def school
    data.willowtree.school.first[1]
  end
end
