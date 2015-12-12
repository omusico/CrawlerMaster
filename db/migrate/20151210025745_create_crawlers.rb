class CreateCrawlers < ActiveRecord::Migration
  def change
    create_table :crawlers do |t|
      t.string :name
      t.string :short_name
      t.string :class_name
      t.string :organization_code
      t.string :setting

      t.timestamps null: false
    end
  end
end
