class FixType < ActiveRecord::Migration[6.1]
  def change
    rename_column :clients, :type, :type_entreprise
  end
end
