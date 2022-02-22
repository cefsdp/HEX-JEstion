class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.references :junior, null: false, foreign_key: true
      t.string :sexe
      t.string :langue
      t.string :prenom
      t.string :nom
      t.string :email
      t.string :telephone
      t.string :entreprise
      t.string :poste
      t.string :site_web
      t.string :telephone_entreprise
      t.string :siret
      t.string :type
      t.string :activite
      t.string :adresse
      t.string :ville
      t.string :code_postal
      t.string :pays
      t.string :provenance
      t.string :premier_contact

      t.timestamps
    end
  end
end
