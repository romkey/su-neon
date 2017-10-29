class NewsSource < ApplicationRecord
  def self.from_json(json)
    objs = JSON.parse json, symbolize_keys: true

    objs.each do |obj|
      NewsSource.create! obj
    end
  end
end
