class CreateMandatMembres < ActiveRecord::Migration[6.1]
  def change
    create_table :mandat_membres do |t|
      t.references :membre, null: false, foreign_key: true
      t.references :pole, null: false, foreign_key: true
      t.references :poste, null: false, foreign_key: true
      t.date :annee_debut
      t.date :annee_fin

      t.timestamps
    end
  end
end
