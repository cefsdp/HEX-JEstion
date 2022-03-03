class AddCommentaireChoixToPostulants < ActiveRecord::Migration[6.1]
  def change
    add_column :postulants, :commentaire_choix, :string
  end
end
