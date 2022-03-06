class CreateDocAdherents < ActiveRecord::Migration[6.1]
    def change
      create_table :document_adherents do |t|
        t.references :adherent, null: false, foreign_key: true
        t.string :nom
        t.string :ref_doc
        t.string :validite
        t.date :date_signature

        t.timestamps
      end
    end
  end
  