class AddUsageInterneToDocumentIntervenants < ActiveRecord::Migration[6.1]
  def change
    add_column :document_intervenants, :usage_interne, :boolean
  end
end
