class CreateMandatRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :mandat_requests do |t|
      t.references :poste, null: false, foreign_key: true
      t.references :pole, null: false, foreign_key: true
      t.references :membre, null: false, foreign_key: true
      t.date :date_debut
      t.date :date_fin
      t.string :status

      t.timestamps
    end
  end
end
