class AddArchiveToPoste < ActiveRecord::Migration[6.1]
  def change
    add_column :postes, :achive, :boolean
  end
end
