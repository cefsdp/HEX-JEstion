class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.references :junior_configuration, null: false, foreign_key: true
      t.string :nom

      t.timestamps
    end
  end
end
