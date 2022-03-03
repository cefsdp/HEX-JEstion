class AddLieuxToPhase < ActiveRecord::Migration[6.1]
  def change
    add_column :phases, :lieux_mission, :string
    add_column :phases, :specialisation_postulant, :string, array: true, default: []
    add_column :phases, :niveau_etude_postulant, :string, array: true, default: []
  end
end
