class AddDateSignatureToDocumentPostulants < ActiveRecord::Migration[6.1]
  def change
    add_column :document_postulants, :date_signature, :date
  end
end
