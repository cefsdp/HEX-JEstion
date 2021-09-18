class AddSpecialisationEtudeToAdherent < ActiveRecord::Migration[6.1]
  def change
    add_column :adherents, :specialisation_etude, :string
  end
end
