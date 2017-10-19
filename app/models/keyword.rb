class Keyword < ApplicationRecord
  belongs_to :sign

  def normalized
    name.stem
  end
end
