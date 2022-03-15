class AddJuniorConfigurationToConfigDocEtudes < ActiveRecord::Migration[6.1]
  def change
    add_reference :config_doc_etudes, :junior_configuration, null: false, foreign_key: true
  end
end
