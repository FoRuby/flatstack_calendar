class AddUserToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :user, null: false, foreign_key: true
  end
end
