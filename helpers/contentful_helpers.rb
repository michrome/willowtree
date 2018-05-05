require "contentful"

module ContentfulHelpers
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

  def articles
    contentful_data.articles
  end

  def diary_dates
    contentful_data.diary_dates
  end

  def school
    contentful_data.school.first[1]
  end

  private

  def contentful_data
    data.send(ENV["CONTENTFUL_SPACE"])
  end
end
