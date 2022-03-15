class AddUsageInterneToDocumentPhases < ActiveRecord::Migration[6.1]
  def change
    add_column :document_phases, :usage_interne, :boolean
  end
end
