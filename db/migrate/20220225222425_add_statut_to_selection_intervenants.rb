class AddStatutToSelectionIntervenants < ActiveRecord::Migration[6.1]
  def change
    add_column :selection_intervenants, :active, :boolean
  end
end
