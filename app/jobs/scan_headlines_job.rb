require 'rss'
require 'open-uri'
require 'pp'

class ScanHeadlinesJob < ApplicationJob
  queue_as :default

  def perform
    RecentHeadline.update_all(current: false)
    Sign.update_all(hits: 0, score: 1.0)
    NewsSource.all.each do |ns|
      ScanHeadlinesJob.scan(ns)
    end

    threshold = Config.first.threshold / 100.0

    max_keywords = Sign.all.map { |sign| sign.keywords.count }.max
    max_keywords *= 1.0

    Sign.find_each do |sign|
      keyword_count = sign.keywords.count
      puts "#{sign.name} score #{sign.score} max keywords #{max_keywords} keyword count #{keyword_count}  hits #{sign.hits}"
      if keyword_count > 0
        sign.update_attributes(score: max_keywords/keyword_count * sign.hits)
      end
      puts "#{sign.name} #{sign.score}"
    end

    max_score = Sign.all.map { |sign| puts "#{sign.name} #{sign.score}" ; sign.score }.max
    Sign.find_each do |sign|
      sign.update_attributes(score: (sign.score/1.0)*max_score)
      if sign.score >= threshold
        puts "ON >>> #{sign.name} #{sign.score} #{threshold}"
        sign.turn_on
      else
        puts "0FF >>> #sign.name} #{sign.score} #{threshold}"
        sign.turn_off
      end
      puts ">>> #{sign.name} keywords #{sign.keywords.count} hits #{sign.hits} score #{sign.score}"
    end
  end

  def self.scan(source)
    begin
      feed_file = open source.feed_url

      parser = RSS::Parser.new feed_file
      feed = parser.parse
      feed.items.each do |item|
        rh = RecentHeadline.find_by link: item.link
        unless rh
          rh = RecentHeadline.create  headline: item.title,
                                   link: item.link,
                                   news_source: source,
                                   current: true
        end

        Keyword.find_each do |keyword|
          title = rh.normalized.downcase.gsub /'"@,\.\?/, ''

          if title.split(' ').include?(keyword.normalized)
            puts "hit '#{keyword.name}' in '#{item.title}'"
            keyword.signs do |sign|
              sign.update_attributes(hits: sign.hits + 1)
            end
          end
        end
      end

      source.update_attributes(last_processed_at: Time.now)
    rescue
      return
    end
  end
end
