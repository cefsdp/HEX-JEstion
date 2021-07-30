class AddAdminToMembres < ActiveRecord::Migration[6.1]
  def change
    add_column :membres, :admin, :boolean
  end
end
