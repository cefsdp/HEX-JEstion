class CreatePostulants < ActiveRecord::Migration[6.1]
  def change
    create_table :postulants do |t|
      t.string :note
      t.references :selection_intervenant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :commentaire_postulant
      t.string :commentaire_selection

      t.timestamps
    end
  end
end
