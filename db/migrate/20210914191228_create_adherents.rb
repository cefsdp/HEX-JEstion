class CreateAdherents < ActiveRecord::Migration[6.1]
  def change
    create_table :adherents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :prenom
      t.string :nom
      t.string :telephone
      t.string :adresse_postale
      t.string :code_postale
      t.string :ville
      t.string :niveau_etude
      t.string :annee_diplome

      t.timestamps
    end
  end
end
