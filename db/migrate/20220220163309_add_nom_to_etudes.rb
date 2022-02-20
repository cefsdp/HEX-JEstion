class AddNomToEtudes < ActiveRecord::Migration[6.1]
  def change
    add_column :etudes, :nom, :string
  end
end
