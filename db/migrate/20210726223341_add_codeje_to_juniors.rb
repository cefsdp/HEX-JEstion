class AddCodejeToJuniors < ActiveRecord::Migration[6.1]
  def change
    add_column :juniors, :codeje, :string
  end
end
