class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.date :date, null: false
      t.integer :duration, null: false
      t.string :visibility, null: false
      t.string :color, null: false

      t.string :schedule
      t.date :recurring_start_date, null: true
      t.date :recurring_end_date, null: true

      t.string :type, default: 'Event', null: false

      t.timestamps
    end
  end
end
