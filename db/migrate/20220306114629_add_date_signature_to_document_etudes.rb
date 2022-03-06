class AddDateSignatureToDocumentEtudes < ActiveRecord::Migration[6.1]
  def change
    add_column :document_etudes, :date_signature, :date
  end
end
