class AddRaisonInvalidToDocumentAdherent < ActiveRecord::Migration[6.1]
  def change
    add_column :document_adherents, :raison_invalid, :string
  end
end
