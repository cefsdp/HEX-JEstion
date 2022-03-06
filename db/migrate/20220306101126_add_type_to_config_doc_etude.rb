class AddTypeToConfigDocEtude < ActiveRecord::Migration[6.1]
  def change
    add_column :config_doc_etudes, :type, :string
  end
end
