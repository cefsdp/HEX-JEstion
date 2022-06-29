class RemoveShowAdherentFromPermissions < ActiveRecord::Migration[6.1]
  def change
    remove_column :permissions, :show_adherent, :boolean
    remove_column :permissions, :edit_adherent, :boolean
    remove_column :permissions, :show_client, :boolean
    remove_column :permissions, :create_client, :boolean
    remove_column :permissions, :update_client, :boolean
    remove_column :permissions, :show_etude, :boolean
    remove_column :permissions, :update_etude, :boolean
    remove_column :permissions, :create_etude, :boolean
    remove_column :permissions, :create_intervenant, :boolean
    remove_column :permissions, :update_intervenant, :boolean
    remove_column :permissions, :show_junior, :boolean
    remove_column :permissions, :create_junior, :boolean
    remove_column :permissions, :update_junior, :boolean
    remove_column :permissions, :update_mandat_membre, :boolean
    remove_column :permissions, :update_mandat_request, :boolean
    remove_column :permissions, :destroy_mandat_request, :boolean
    remove_column :permissions, :index_membre, :boolean
    remove_column :permissions, :show_membre_request, :boolean
  end
end
