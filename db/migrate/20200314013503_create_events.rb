class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title,         null: false
      t.text :description
      t.datetime :start_date, null: false
      t.datetime :end_date,   null: false
      t.string :schedule
      t.string :event_type,    null: false
      t.string :color,         null: false

      t.timestamps
    end
  end
end
