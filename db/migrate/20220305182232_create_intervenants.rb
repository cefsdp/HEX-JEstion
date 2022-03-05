class CreateIntervenants < ActiveRecord::Migration[6.1]
  def change
    create_table :intervenants do |t|
      t.references :phase, null: false, foreign_key: true
      t.string :ref_rm

      t.timestamps
    end
  end
end
