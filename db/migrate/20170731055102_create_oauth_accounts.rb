class CreateOauthAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :oauth_accounts do |t|
      t.integer :user_id
      t.string :provider
      t.string :image_url
      t.string :profile_url
      t.string :access_token
      t.text :raw_data
    end
    add_index :oauth_accounts, :user_id
  end
end
