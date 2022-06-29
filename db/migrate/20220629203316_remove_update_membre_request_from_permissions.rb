class RemoveUpdateMembreRequestFromPermissions < ActiveRecord::Migration[6.1]
  def change
    remove_column :permissions, :update_membre_request, :boolean
    remove_column :permissions, :destroy_membre_request, :boolean
    remove_column :permissions, :create_pole, :boolean
    remove_column :permissions, :update_pole, :boolean
    remove_column :permissions, :create_poste, :boolean
    remove_column :permissions, :update_poste, :boolean
    remove_column :permissions, :update_postulant, :boolean
    remove_column :permissions, :create_prestation, :boolean
    remove_column :permissions, :update_prestation, :boolean
    remove_column :permissions, :create_selection_intervenant, :boolean
    remove_column :permissions, :update_selection_intervenant, :boolean
    remove_column :permissions, :create_config_doc_adherent, :boolean
    remove_column :permissions, :update_config_doc_adherent, :boolean
    remove_column :permissions, :create_config_doc_etude, :boolean
    remove_column :permissions, :update_config_doc_etude, :boolean
    remove_column :permissions, :create_document_adherent, :boolean
    remove_column :permissions, :update_document_adherent, :boolean
    remove_column :permissions, :create_document_adhesion, :boolean
    remove_column :permissions, :update_document_adhesion, :boolean
    remove_column :permissions, :create_document_etude, :boolean
    remove_column :permissions, :update_document_etude, :boolean
  end
end
