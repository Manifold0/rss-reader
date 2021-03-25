class RssReader
  require 'rss' # basic RSS library to parse the feed
  require 'open-uri' # basic wrapper library for HTTP to get feed data

  def initialize(rss_dictionary, days_inactive)
    @rss_dictionary = rss_dictionary
    @days_inactive = days_inactive
  end

  def inactive_companies

  end

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

  def includes_inactive?(pub_dates, inactivity_window)
    pub_dates.each_with_index do |date, index|
      unless index == pub_dates.size - 1
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