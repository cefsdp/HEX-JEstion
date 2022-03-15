class RemoveUsageInterneFromDocumentIntervenants < ActiveRecord::Migration[6.1]
  def change
    remove_column :document_intervenants, :usage_interne, :boolean
  end
end
