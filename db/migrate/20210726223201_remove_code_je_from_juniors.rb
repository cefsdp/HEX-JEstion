class RemoveCodeJeFromJuniors < ActiveRecord::Migration[6.1]
  def change
    remove_column :juniors, :CodeJE, :string
  end
end
