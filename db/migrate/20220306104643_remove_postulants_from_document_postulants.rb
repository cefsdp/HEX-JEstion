class RemovePostulantsFromDocumentPostulants < ActiveRecord::Migration[6.1]
  def change
    remove_reference :document_postulants, :postulants, null: false, foreign_key: true
  end
end
