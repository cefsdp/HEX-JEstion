class RemoveEtapeFromPhases < ActiveRecord::Migration[6.1]
  def change
    remove_reference :phases, :etape, null: false, foreign_key: true
  end
end
