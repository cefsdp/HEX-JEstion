class CreateUserparams < ActiveRecord::Migration[6.1]
  def change
    create_table :userparams do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :navbar_active, default: 0

      t.timestamps
    end
  end
end
