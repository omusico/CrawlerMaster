class CreateRufusJobs < ActiveRecord::Migration
  def change
    create_table :rufus_jobs do |t|
      t.string  :jid
      t.integer :crawler_id
      t.string  :type

      t.timestamps null: false
    end
  end
end
