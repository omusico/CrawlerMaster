class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string  :organization_code, null: false
      t.string  :department_code
      t.string  :lecturer_name,     null: false
      t.integer :year,              null: false
      t.integer :term,              null: false
      t.string  :name,              null: false
      t.string  :code,              null: false
      t.string  :general_code,      null: false
      t.string  :ucode
      t.boolean :required
      t.integer :credits
      t.string  :url
      t.string  :name_en
      t.boolean :full_semester
      t.integer :day_1
      t.integer :day_2
      t.integer :day_3
      t.integer :day_4
      t.integer :day_5
      t.integer :day_6
      t.integer :day_7
      t.integer :day_8
      t.integer :day_9
      t.integer :period_1
      t.integer :period_2
      t.integer :period_3
      t.integer :period_4
      t.integer :period_5
      t.integer :period_6
      t.integer :period_7
      t.integer :period_8
      t.integer :period_9
      t.string  :location_1
      t.string  :location_2
      t.string  :location_3
      t.string  :location_4
      t.string  :location_5
      t.string  :location_6
      t.string  :location_7
      t.string  :location_8
      t.string  :location_9

      t.timestamps null: false
    end

    add_index "courses", ["general_code"], name: "index_courses_on_general_code", using: :btree
    add_index "courses", ["ucode"], name: "index_courses_on_ucode", using: :btree

  end
end
