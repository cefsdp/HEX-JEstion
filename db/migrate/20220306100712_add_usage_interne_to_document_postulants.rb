class AddUsageInterneToDocumentPostulants < ActiveRecord::Migration[6.1]
  def change
    add_column :document_postulants, :usage_interne, :boolean
  end
end
