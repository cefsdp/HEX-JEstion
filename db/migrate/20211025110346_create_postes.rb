class CreatePostes < ActiveRecord::Migration[6.1]
  def change
    create_table :postes do |t|
      t.references :junior, null: false, foreign_key: true
      t.string :nom

      t.timestamps
    end
  end
end
