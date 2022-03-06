class AddIntervenantToDocumentIntervenants < ActiveRecord::Migration[6.1]
  def change
    add_reference :document_intervenants, :intervenant, null: false, foreign_key: true
  end
end
