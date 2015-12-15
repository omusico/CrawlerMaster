class AddTestColumnsToCrawlers < ActiveRecord::Migration
  def change
    add_column :crawlers, :save_to_db, :boolean, default: false
    add_column :crawlers, :sync,       :boolean, default: false

    Crawler.all.each { |crawler| crawler.save_to_db = false; crawler.sync = false; crawler.save! }
  end
end
