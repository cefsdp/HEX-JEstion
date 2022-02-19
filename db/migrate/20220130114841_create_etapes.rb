class CreateEtapes < ActiveRecord::Migration[6.1]
  def change
    create_table :etapes do |t|
      t.references :etude, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
