class CreateMembreRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :membre_requests do |t|
      t.references :junior, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
