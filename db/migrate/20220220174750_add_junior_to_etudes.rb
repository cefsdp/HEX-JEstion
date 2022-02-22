class AddJuniorToEtudes < ActiveRecord::Migration[6.1]
  def change
    add_reference :etudes, :junior, null: false, foreign_key: true
  end
end
