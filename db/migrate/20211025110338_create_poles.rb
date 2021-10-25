class CreatePoles < ActiveRecord::Migration[6.1]
  def change
    create_table :poles do |t|
      t.references :junior, null: false, foreign_key: true
      t.string :nom

      t.timestamps
    end
  end
end
