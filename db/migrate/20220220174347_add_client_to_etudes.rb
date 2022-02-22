class AddClientToEtudes < ActiveRecord::Migration[6.1]
  def change
    add_reference :etudes, :client, foreign_key: true
  end
end
