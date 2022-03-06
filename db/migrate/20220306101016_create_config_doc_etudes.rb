class CreateConfigDocEtudes < ActiveRecord::Migration[6.1]
  def change
    create_table :config_doc_etudes do |t|
      t.references :junior_configurations, null: false, foreign_key: true
      t.string :nom
      t.boolean :obligatoire
      t.boolean :interne, default: true
      t.boolean :archive

      t.timestamps
    end
  end
end
