require "active_support/core_ext/date/calculations"
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

  def this_week_diary_dates
    start_date = Date.today.beginning_of_week(:sunday)
    end_date = start_date.weeks_since(1)
    range = start_date..end_date
    the_dates = diary_dates.select { |_, diary_date| range === diary_date.date }
    the_dates.sort_by {|_, diary_date| diary_date.date }
  end

  def school
    contentful_data.school.first[1]
  end

  private

  def contentful_data
    data.send(ENV["CONTENTFUL_SPACE"])
  end
end
