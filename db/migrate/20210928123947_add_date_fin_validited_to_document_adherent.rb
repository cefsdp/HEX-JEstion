class AddDateFinValiditedToDocumentAdherent < ActiveRecord::Migration[6.1]
  def change
    add_column :document_adherents, :date_fin_validite, :date
  end
end
