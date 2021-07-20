class CreateJuniors < ActiveRecord::Migration[6.1]
  def change
    create_table :juniors do |t|
      t.string :nom

      t.timestamps
    end
  end
end
