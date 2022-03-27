class AddStatutToPostulants < ActiveRecord::Migration[6.1]
  def change
    add_column :postulants, :statut, :string, default: "pending"
  end
end
