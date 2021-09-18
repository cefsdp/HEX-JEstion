class AddNiveauEtudeToConfigurations < ActiveRecord::Migration[6.1]
  def change
    add_column :configurations, :niveau_etude, :text, array:true, default: []
  end
end
