class RemoveJuniorConfigurationsFromConfigDocEtudes < ActiveRecord::Migration[6.1]
  def change
    remove_reference :config_doc_etudes, :junior_configurations, null: false, foreign_key: true
  end
end
