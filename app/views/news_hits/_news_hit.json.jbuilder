json.extract! news_hit, :id, :news_source_id, :keyword_id, :created_at, :updated_at
json.url news_hit_url(news_hit, format: :json)
