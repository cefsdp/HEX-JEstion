class CreateTresoreries < ActiveRecord::Migration[6.1]
  def change
    create_table :tresoreries do |t|
      t.references :junior, null: false, foreign_key: true
      t.date :debut_exercice
      t.date :fin_exercice

      t.timestamps
    end
  end
end
