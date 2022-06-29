class RemoveCreateDocumentEtudeFromPermissions < ActiveRecord::Migration[6.1]
  def change
    remove_column :permissions, :create_document_intervenant, :boolean
    remove_column :permissions, :update_document_intervenant, :boolean
    remove_column :permissions, :create_document_phase, :boolean
    remove_column :permissions, :update_document_phase, :boolean
    remove_column :permissions, :create_document_postulant, :boolean
    remove_column :permissions, :update_document_postulant, :boolean
    remove_column :permissions, :archive_junior_config, :boolean
    remove_column :permissions, :update_junior_config, :boolean
    remove_column :permissions, :create_mandat, :boolean
    remove_column :permissions, :update_mandat, :boolean
    remove_column :permissions, :create_permission, :boolean
    remove_column :permissions, :update_permission, :boolean
  end
end
