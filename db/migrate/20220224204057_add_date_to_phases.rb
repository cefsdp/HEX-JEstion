class AddDateToPhases < ActiveRecord::Migration[6.1]
  def change
    add_reference :phases, :etude, null: false, foreign_key: true
    add_column :phases, :date_debut, :date
    add_column :phases, :date_fin, :date
    add_column :phases, :nombre_intervenant, :integer
    add_column :phases, :jeh_par_intervenant, :integer
    add_column :phases, :remuneration_par_intervenant, :integer
    add_column :phases, :indemnisation_par_intervenant, :integer
    add_column :phases, :frais, :integer
    add_column :phases, :description_phase, :string
    add_column :phases, :description_mission_intervenant, :string
  end
end
