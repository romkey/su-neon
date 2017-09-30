json.extract! news_source, :id, :name, :feed_url, :last_processed_at, :created_at, :updated_at
json.url news_source_url(news_source, format: :json)
