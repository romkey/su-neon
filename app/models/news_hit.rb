class NewsHit < ApplicationRecord
  belongs_to :news_source
  belongs_to :keyword
end
