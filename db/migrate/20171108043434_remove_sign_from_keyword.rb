class RemoveSignFromKeyword < ActiveRecord::Migration[5.1]
  def change
    Keyword.all.each do |keyword|
      sign = Sign.find keyword.sign_id

      keyword.signs << sign
    end

    remove_column :keywords, :sign_id
  end
end
