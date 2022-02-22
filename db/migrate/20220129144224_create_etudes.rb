class CreateEtudes < ActiveRecord::Migration[6.1]
  def change
    create_table :etudes do |t|
      t.references :client, null: false, foreign_key: true
      t.references :prestation, null: false, foreign_key: true
      t.references :charge_etude, foreign_key: { to_table: :users }
      t.references :charge_qualite, foreign_key: { to_table: :users }
      t.references :charge_rh, foreign_key: { to_table: :users }
      t.string :statut
      t.date :date_debut
      t.string :ref_etude

      t.timestamps
    end
  end
end
