class CreateUrlInfos < ActiveRecord::Migration
  def change
    create_table :url_infos do |t|
      t.references :stored_url
      t.string :host
      t.string :browser_info
  	  t.string :browser_platform
      t.timestamps null: false
    end
  end
end
