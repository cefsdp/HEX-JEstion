class RemoveIntervenantsFromDocumentIntervenants < ActiveRecord::Migration[6.1]
  def change
    remove_reference :document_intervenants, :intervenants, null: false, foreign_key: true
  end
end
