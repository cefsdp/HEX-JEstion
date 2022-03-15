class CreateDocumentPostulants < ActiveRecord::Migration[6.1]
  def change
    create_table :document_postulants do |t|
      t.references :postulants, null: false, foreign_key: true
      t.string :ref_doc
      t.string :validite

      t.timestamps
    end
  end
end
