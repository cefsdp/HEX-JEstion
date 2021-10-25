class ChangeAchivePoste < ActiveRecord::Migration[6.1]
  def change
    rename_column :postes, :achive, :archive
  end
end
