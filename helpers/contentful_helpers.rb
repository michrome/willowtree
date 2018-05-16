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

  def contentful_image_url(id)
    client = Contentful::Client.new(
      space: ENV["CONTENTFUL_SPACE"],
      access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
    )
    image = client.asset(id).image_url
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
  end

  def school
    contentful_data.school.first[1]
  end

  def resource_set(set_name)
    result = Hash.new
    sets = contentful_data["resource_sets"]
    set = sets.select { |_, resource_set| resource_set.name = set_name }.first
    resources = set[1]["resources"]
    resources.each do |resource|
      result[resource.name] = resource.value
    end
    result
  end

  def school_resource_set
    resource_set("school")
  end

  def site_resource_set
    resource_set("site")
  end

  def school_logo_url(options = {})
    cloudinary_image_url(contentful_image_url(school_resource_set["logoID"]), options)
  end

  def page_title(title = nil)
    if title.blank?
      site_resource_set["name"]
    else
      "#{title} - #{site_resource_set["name"]}"
    end
  end

  private

  def contentful_data
    # Returns a Hash of the content types synced by middleman contentful so:
    # contentful_data['content_type'] returns a Hash of entries of that content type
    # contentful_data['content_type'].first returns a two element Array
    # contentful_data['content_type'].first.first returns the ID of the entry
    # contentful_data['content_type'].first.last returns the entry as a Hash
    # contentful_data['content_type'].first.last.first is a two element Array
    # contentful_data['content_type'].first.last.first.first is the field name
    # contentful_data['content_type'].first.last.first.last is the field value
    data.send(ENV["CONTENTFUL_SPACE"]) # A Hash
  end
end
