class AddDateSignatureToEtudes < ActiveRecord::Migration[6.1]
  def change
    add_column :etudes, :date_signature, :date
  end
end
