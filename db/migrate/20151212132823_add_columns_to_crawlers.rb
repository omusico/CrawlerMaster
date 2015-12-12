class AddColumnsToCrawlers < ActiveRecord::Migration
  def change
    add_column :crawlers, :data_management_api_endpoint, :string
    add_column :crawlers, :data_management_api_key, :string
    add_column :crawlers, :data_name, :string
  end
end
