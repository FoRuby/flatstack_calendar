class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.string :visibility, null: false
      t.string :color, null: false
      t.string :type, default: 'Event', null: false

      # SimpleEvent
      t.date :date
      t.integer :duration

      # RecurringEvent
      t.string :schedule
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
