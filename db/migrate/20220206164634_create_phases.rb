class CreatePhases < ActiveRecord::Migration[6.1]
  def change
    create_table :phases do |t|
      t.string :nom

      t.timestamps
    end
  end
end
