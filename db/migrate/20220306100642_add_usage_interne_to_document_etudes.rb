class AddUsageInterneToDocumentEtudes < ActiveRecord::Migration[6.1]
  def change
    add_column :document_etudes, :usage_interne, :boolean
  end
end
