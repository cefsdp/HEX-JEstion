class RemoveClientFromEtudes < ActiveRecord::Migration[6.1]
  def change
    remove_reference :etudes, :client, null: false, foreign_key: true
  end
end
