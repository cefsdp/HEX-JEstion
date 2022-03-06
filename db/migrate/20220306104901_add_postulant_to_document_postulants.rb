class AddPostulantToDocumentPostulants < ActiveRecord::Migration[6.1]
  def change
    add_reference :document_postulants, :postulant, null: false, foreign_key: true
  end
end
