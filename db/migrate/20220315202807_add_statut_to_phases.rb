class AddStatutToPhases < ActiveRecord::Migration[6.1]
  def change
    add_column :phases, :statut, :string
  end
end
