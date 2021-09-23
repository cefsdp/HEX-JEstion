class CreateDocumentAdherents < ActiveRecord::Migration[6.1]
  def change
    create_table :document_adherents do |t|
      t.references :adherents, null: false, foreign_key: true
      t.string :nom
      t.boolean :obligatoire
      t.string :duree
      t.string :format_duree
      t.boolean :validite
      t.boolean :archive

      t.timestamps
    end
  end
end
