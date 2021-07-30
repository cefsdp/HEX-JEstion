class CreateMembres < ActiveRecord::Migration[6.1]
  def change
    create_table :membres do |t|
      t.references :membre_request, null: false, foreign_key: true
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
