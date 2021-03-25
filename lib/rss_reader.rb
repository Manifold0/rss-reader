class RssReader
  require 'rss' # basic RSS library to parse the feed
  require 'open-uri' # basic wrapper library for HTTP to get feed data
  require_relative 'example_data'

  # rss_dictionary: hash of company names and RSS urls
  # days_inactive: integer number of days, default 1
  def initialize(rss_dictionary, days_inactive = 1)
    @rss_dictionary = rss_dictionary
    @days_inactive = days_inactive
  end

  def inactive_companies
    inactive = []
    @rss_dictionary.each do |company, urls|
      dates = []
      # Assumes URLs will come in an array
      urls.each do |url|
        dates << rss_feed_pub_dates(url)
      end
      # Flatten nested arrays, then sort dates and reverse them to get sorting from newest to oldest
      dates = dates.flatten.sort.reverse
      if includes_inactive?(dates, @days_inactive)
        inactive << company
      end
    end
    inactive
  end

  # Parse RSS feed and pull pubDates out of each item
  def rss_feed_pub_dates(feed_url)
    pub_dates = []
    URI.open(feed_url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        pub_dates << item.pubDate
      end
    end
    pub_dates
  end

  # Compare dates to check if the time between any two dates is ever greater than the given window
  def includes_inactive?(dates, inactivity_period)
    dates.each_with_index do |date, index|
      unless index == pub_dates.size - 1
        # Compare dates with simple operand to get simple number of days difference
        time_between = date - pub_dates[index + 1]
        if time_between > inactivity_period
          return true
        end
      end
    end
    false
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