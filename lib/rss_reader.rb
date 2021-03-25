class RssReader
  require 'rss' # basic RSS library to parse the feed
  require 'open-uri' # basic wrapper library for HTTP to get feed data

  # rss_dictionary: hash of company names and RSS urls
  # days_inactive: integer number of days
  def initialize(rss_dictionary, days_inactive)
    @rss_dictionary = rss_dictionary
    @days_inactive = days_inactive
  end

  def inactive_companies

  end

  # Parse RSS feed and pull pubDates out of each item
  def rss_feed_pub_dates(feed_url)
    pub_dates = []
    open(feed_url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        pub_dates << item.pubDate
      end
    end
    pub_dates
  end

  # Compare dates to check if the time between any two dates is ever greater than the given window
  def includes_inactive?(dates, inactivity_window)
    dates.each_with_index do |date, index|
      unless index == pub_dates.size - 1
        # Compare dates with simple operand to get simple number of days difference
        time_between = date - pub_dates[index + 1]
        if time_between > inactivity_window
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