class RemovePhasesFromDocumentPhases < ActiveRecord::Migration[6.1]
  def change
    remove_reference :document_phases, :phases, null: false, foreign_key: true
  end
end
