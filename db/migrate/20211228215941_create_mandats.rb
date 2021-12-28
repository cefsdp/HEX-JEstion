class CreateMandats < ActiveRecord::Migration[6.1]
  def change
    create_table :mandats do |t|
      t.references :mandat_request, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
