class AddNomToDocumentEtudesIntervenantsPostulantsPhasesAdherents < ActiveRecord::Migration[6.1]
  def change
    add_column :document_etudes, :nom, :string
    add_column :document_phases, :nom, :string
    add_column :document_postulants, :nom, :string
    add_column :document_intervenants, :nom, :string
  end
end
