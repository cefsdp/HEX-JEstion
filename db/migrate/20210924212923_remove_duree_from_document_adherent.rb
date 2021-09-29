class RemoveDureeFromDocumentAdherent < ActiveRecord::Migration[6.1]
  def change
    remove_column :document_adherents, :duree, :string
    remove_column :document_adherents, :format_duree, :string
  end
end
