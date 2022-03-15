class AddTypeDocToConfigDocEtudes < ActiveRecord::Migration[6.1]
  def change
    add_column :config_doc_etudes, :type_doc, :string
  end
end
