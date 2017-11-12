class Keyword < ApplicationRecord
  has_and_belongs_to_many :signs
  before_validation :set_normalized

  def normalized!
    name.downcase.stem
  end

  def self.from_json(json)
    objs = JSON.parse json, symbolize_keys: true

    objs.each do |obj|
      Keyword.create! obj
    end
  end

protected
  def set_normalized
    self.normalized = normalized!
  end
end
