class RemoveUsageInterneFromDocumentPhases < ActiveRecord::Migration[6.1]
  def change
    remove_column :document_phases, :usage_interne, :boolean
  end
end
