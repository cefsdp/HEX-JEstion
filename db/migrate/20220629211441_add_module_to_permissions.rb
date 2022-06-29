class AddModuleToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :module_etude, :boolean
    add_column :permissions, :module_adherent, :boolean
    add_column :permissions, :module_client, :boolean
    add_column :permissions, :module_membre, :boolean
    add_column :permissions, :module_tresorerie, :boolean
    add_column :permissions, :module_parametres, :boolean
  end
end
