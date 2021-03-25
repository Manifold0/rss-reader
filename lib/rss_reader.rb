class RssReader
  require 'rss' # basic RSS library to parse the feed
  require 'open-uri' # basic wrapper library for HTTP to get feed data

  def initialize(rss_dictionary, days_inactive)
    @rss_dictionary = rss_dictionary
    @days_inactive = days_inactive
  end


end


# Example hash
# {
#   "Company1": ["url1"],
#   "Company2": ["url2", "url3"]
# }

# Example RSS data
# {

# }