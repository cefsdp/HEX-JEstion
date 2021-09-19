class CreateJuniorConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :junior_configurations do |t|
      t.references :junior, null: false, foreign_key: true
      t.text :niveau_etude, array:true, default: []
      t.text :specialisation_etude, array:true, default: []

      t.timestamps
    end
  end
end
