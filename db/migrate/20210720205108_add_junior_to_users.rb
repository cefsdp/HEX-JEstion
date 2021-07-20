class AddJuniorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :junior, null: false, foreign_key: true
  end
end
