class AddTypeEntrepriseToJuniorConfigurations < ActiveRecord::Migration[6.1]
  def change
    add_column :junior_configurations, :types_entreprises, :string, array:true, default: []
    add_column :junior_configurations, :provenances_clients, :string, array:true, default: []
    add_column :junior_configurations, :methodes_premier_contact, :string, array:true, default: []
  end
end
