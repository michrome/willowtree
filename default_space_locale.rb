require "contentful"
client = Contentful::Client.new(
  access_token: "ba4951e8a62ac32ea80edcd0655aadb2e8bcd5656ef15a82aae6cdd290c88925",
  space: "e3yk46djt0o5",
)
puts client.space.locales.find { |e| e.default == true }.code
