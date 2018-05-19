class CreateStoredUrls < ActiveRecord::Migration
  def change
    create_table :stored_urls do |t|
      t.text :original_url
      t.string :short_url
      t.string :purify_url
      t.timestamps null: false
    end
  end
end
