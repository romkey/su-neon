require 'stopwords'
require 'stemmify'

class RecentHeadline < ApplicationRecord
  belongs_to :news_source

  def stemmed
    
  end

  def stopped
    headline.stem
  end

  def normalized
    filter = Stopwords::Snowball::Filter.new "en"
    filter.filter(headline.split).map { |word| word.stem }.join(' ')
  end
end
