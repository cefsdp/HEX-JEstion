class AddFileStatusToAdherents < ActiveRecord::Migration[6.1]
  def change
    add_column :adherents, :file_status, :string
  end
end
