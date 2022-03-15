class AddDateSignatureToDocumentIntervenants < ActiveRecord::Migration[6.1]
  def change
    add_column :document_intervenants, :date_signature, :date
  end
end
