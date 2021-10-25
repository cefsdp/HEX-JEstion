class CreatePermissionsMembres < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions_membres do |t|
      t.references :junior, null: false, foreign_key: true
      t.references :membre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
