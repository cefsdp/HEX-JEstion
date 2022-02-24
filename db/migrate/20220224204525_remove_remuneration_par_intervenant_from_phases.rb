class RemoveRemunerationParIntervenantFromPhases < ActiveRecord::Migration[6.1]
  def change
    remove_column :phases, :remuneration_par_intervenant, :integer
    remove_column :phases, :indemnisation_par_intervenant, :integer

    add_column :phases, :indemnisation_par_jeh, :integer
    add_column :phases, :remuneration_par_jeh, :integer
  end
end
