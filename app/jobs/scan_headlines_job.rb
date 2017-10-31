require 'rss'
require 'open-uri'
require 'pp'

class ScanHeadlinesJob < ApplicationJob
  queue_as :default

  def perform
    state = {}
    Sign.all.each do |sign|
      state[sign.name] = { hits: 0,
                           keyword_count: Keyword.where(sign: sign).count,
                           score: 0.0,
                           sign: sign
                         }
    end

    NewsSource.all.each do |ns|
      ScanHeadlinesJob.scan(ns, state)
    end

    threshold = Config.first.threshold / 100.0

    max_keywords = state.map { |key, st| st[:keyword_count] }.max
    max_keywords *= 1.0

    state.each do |key, st|
      puts "#{st[:sign].name} score #{st[:score]} max keywords #{max_keywords} keyword count #{st[:keyword_count]}  hits #{st[:hits]}"
      if st[:keyword_count] > 0
        st[:score] = max_keywords/st[:keyword_count] * st[:hits]
      end
      puts "#{st[:sign].name} #{st[:score]}"
    end

    max_score = state.map { |key, st| puts "#{st[:sign].name} #{st[:score]}" ; st[:score] }.max
    state.each do |key, st|
      st[:score] /= 1.0*max_score
      if st[:score] >= threshold
        puts "ON >>> #{st[:sign].name} #{st[:score]} #{threshold}"
        st[:sign].turn_on
      else
        puts "0FF >>> #{st[:sign].name} #{st[:score]} #{threshold}"
        st[:sign].turn_off
      end
      puts ">>> #{key} keywords #{st[:keyword_count]} hits #{st[:hits]} score #{st[:score]}"
    end

    state
  end

  def self.scan(source, state)
    begin
      feed_file = open source.feed_url

      parser = RSS::Parser.new feed_file
      feed = parser.parse
      feed.items.each do |item|
        rh = RecentHeadline.find_by link: item.link
        unless rh
          rh = RecentHeadline.create  headline: item.title,
                                   link: item.link,
                                   news_source: source
        end

        Keyword.find_each do |keyword|
          title = rh.normalized.downcase.gsub /'"@,\.\?/, ''

          if title.split(' ').include?(keyword.normalized)
            puts "hit '#{keyword.name}' in '#{item.title}'"
            state[keyword.sign.name][:hits] += 1
          end
        end
      end

      source.update_attributes(last_processed_at: Time.now)
    rescue
      return
    end
  end
end
