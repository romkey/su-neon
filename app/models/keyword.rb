class Keyword < ApplicationRecord
  belongs_to :sign

  def normalized
    name.stem
  end

  def self.from_json(json)
    objs = JSON.parse json, symbolize_keys: true

    objs.each do |obj|
      Keyword.create! obj
    end
  end
end
