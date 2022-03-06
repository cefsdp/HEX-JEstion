class RemoveTypeFromConfigDocEtudes < ActiveRecord::Migration[6.1]
  def change
    remove_column :config_doc_etudes, :type, :string
  end
end
