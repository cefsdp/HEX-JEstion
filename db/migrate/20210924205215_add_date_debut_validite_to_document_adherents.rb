class AddDateDebutValiditeToDocumentAdherents < ActiveRecord::Migration[6.1]
  def change
    add_column :document_adherents, :date_debut_validite, :date
  end
end
