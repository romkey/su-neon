require 'rss'
require 'open-uri'
require 'pp'

class ScanHeadlinesJob < ApplicationJob
  queue_as :default

  def perform
    state = {}
    Sign.each do |sign|
      state[sign.name] = { hits: 0,
                           keyword_count: sign.keywords.count,
                           sign: sign
                         }
    end

    NewsSource.all.each do |ns|
      self.scan.perform_now(ns, state)
    end

    threshold = Config.first.threshold

    max_keywords = state.pluck(:keyword_count).max
    max_keywords *= 1.0

    state.each do |key, st|
      st[:score] = max_keywords/st[:keyword_count] * st[:hits]
    end

    max_score = state.pluck(:score).max
    state.each do |key, st|
      st[:score] /= 1.0*max_score
      if st[:score] >= threshold
        st[:sign].turn_on
      else
        st[:sign].turn_off
      end
    end
  end

  def self.scan(source)
    begin
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
            state[keyword.sign.name].hits += 1
          end
        end
      end

      source.update_attributes(last_processed_at: Time.now)
    rescue
      return
    end
  end
end
