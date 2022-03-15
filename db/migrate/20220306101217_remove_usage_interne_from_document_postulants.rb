class RemoveUsageInterneFromDocumentPostulants < ActiveRecord::Migration[6.1]
  def change
    remove_column :document_postulants, :usage_interne, :boolean
  end
end
