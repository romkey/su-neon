require 'rss'
require 'open-uri'
require 'pp'

class ScanHeadlinesJob < ApplicationJob
  queue_as :default

  def perform(source)
    feed_file = open source.feed_url

    parser = RSS::Parser.new feed_file
    feed = parser.parse
    feed.items.each do |item|
      unless RecentHeadline.find_by link: item.link
        RecentHeadline.create headline: item.title,
                              link: item.link,
                              news_source: source
      end

      Keyword.find_each do |keyword|
        if item.title.downcase.match keyword.name
          keyword.sign.turn_on
        end
      end
    end
  end
end
