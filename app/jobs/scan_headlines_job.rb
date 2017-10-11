require 'rss'
require 'open-uri'

class ScanHeadlinesJob < ApplicationJob
  queue_as :default

  def perform(source)
    feed_file = open source.feed_url

    parser = RSS::Parser.new feed_file
    feed = parser.parse
    feed.items.each do |item|
      puts item.title
      next

      Keyword.find_each do |keyword|
        if item.title.downcase.match keyword
          keyword.signs.each { |sign| sign.turn_on }
        end
      end
    end
  end
end
