class RemoveUsageInterneFromDocumentEtudes < ActiveRecord::Migration[6.1]
  def change
    remove_column :document_etudes, :usage_interne, :boolean
  end
end
