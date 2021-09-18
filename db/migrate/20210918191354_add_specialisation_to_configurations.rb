class AddSpecialisationToConfigurations < ActiveRecord::Migration[6.1]
  def change
    add_column :configurations, :specialisation_etude, :text, array:true, default: []
  end
end
