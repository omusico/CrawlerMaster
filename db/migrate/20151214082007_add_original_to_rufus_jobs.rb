class AddOriginalToRufusJobs < ActiveRecord::Migration
  def change
    add_column :rufus_jobs, :original, :string
  end
end
