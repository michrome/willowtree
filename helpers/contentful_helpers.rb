require "active_support/core_ext/date/calculations"
require "contentful"

module ContentfulHelpers
  def contentful_image_url(id)
    client = Contentful::Client.new(
      space: ENV["CONTENTFUL_SPACE"],
      access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
    )
    image = client.asset(id).image_url
  end

  def contentful_image_title(id)
    client = Contentful::Client.new(
      space: ENV["CONTENTFUL_SPACE"],
      access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
    )
    image = client.asset(id).description
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

  def resource_set(set_name)
    result = Hash.new
    sets = contentful_data["resource_sets"]
    set = sets.select { |_, resource_set| resource_set["name"] == set_name }
    resources = set.values[0]["resources"]
    resources.each do |resource|
      result[resource["name"]] = resource["value"]
    end
    result
  end

  def school
    resource_set("school")
  end

  def site
    resource_set("site")
  end

  def school_logo_url(cloudinary_options = [])
    cloudinary_image_url(
      contentful_image_url(school["logoID"]),
      cloudinary_options
    )
  end

  def page_title(title = nil)
    if title.blank?
      site["name"]
    else
      "#{title} - #{site["name"]}"
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
