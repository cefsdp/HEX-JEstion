class AddDateSignatureToDocumentPhases < ActiveRecord::Migration[6.1]
  def change
    add_column :document_phases, :date_signature, :date
  end
end
