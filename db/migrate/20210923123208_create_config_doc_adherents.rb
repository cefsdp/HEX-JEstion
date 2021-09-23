class CreateConfigDocAdherents < ActiveRecord::Migration[6.1]
  def change
    create_table :config_doc_adherents do |t|
      t.references :junior_configurations, null: false, foreign_key: true
      t.string :nom
      t.boolean :obligatoire
      t.string :duree_validite
      t.string :format_duree_validite
      t.boolean :archive

      t.timestamps
    end
  end
end
