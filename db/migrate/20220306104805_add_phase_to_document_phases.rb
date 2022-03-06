class AddPhaseToDocumentPhases < ActiveRecord::Migration[6.1]
  def change
    add_reference :document_phases, :phase, null: false, foreign_key: true
  end
end
