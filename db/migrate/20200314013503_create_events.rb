class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title,     null: false
      t.text :description, null: false
      t.date :start_date,  null: false
      t.date :end_date
      t.string :type,      null: false
      t.string :color,     null: false

      t.timestamps
    end
  end
end
