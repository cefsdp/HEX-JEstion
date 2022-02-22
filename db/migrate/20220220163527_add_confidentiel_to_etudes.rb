class AddConfidentielToEtudes < ActiveRecord::Migration[6.1]
  def change
    add_column :etudes, :confidentielle, :boolean, default: false
  end
end
