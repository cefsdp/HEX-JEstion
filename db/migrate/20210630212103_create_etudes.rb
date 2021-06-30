class CreateEtudes < ActiveRecord::Migration[6.1]
  def change
    create_table :etudes do |t|
      t.string :reference

      t.timestamps
    end
  end
end
