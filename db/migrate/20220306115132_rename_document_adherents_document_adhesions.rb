class RenameDocumentAdherentsDocumentAdhesions < ActiveRecord::Migration[6.1]
  def change
    rename_table :document_adherents, :document_adhesions
  end
end
