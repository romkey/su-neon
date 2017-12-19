require 'stopwords'
require 'stemmify'

class RecentHeadline < ApplicationRecord
  belongs_to :news_source

  def stemmed
    
  end

  def stopped
    headline.stem
  end

  def html_fixed
    headline.gsub('&apos;', '\'').gsub('&quot;', '"').gsub('&mdash', '--').gsub('&rsquo', '\'').gsub('&lsquo', '\'').gsub('&nbsp;', ' ').gsub('&eacute;', 'e').gsub('&ndash;', '-').gsub('&#038;', '&')
  end

  def normalized
    filter = Stopwords::Snowball::Filter.new "en"
    filter.filter(headline.downcase.gsub(/[^a-z\s]/, '').split).map { |word| word.stem }
  end

  def matched_keywords
    title_words = normalized

    Keyword.all.select do |keyword|
      title_words.include?(keyword.normalized)
    end
  end

  def self.from_json(json)
    objs = JSON.parse json, symbolize_keys: true

    objs.each do |obj|
      RecentHeadline.create! obj
    end
  end
end
