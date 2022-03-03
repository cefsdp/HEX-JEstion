class CreateSelectionIntervenants < ActiveRecord::Migration[6.1]
  def change
    create_table :selection_intervenants do |t|
      t.references :phase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
