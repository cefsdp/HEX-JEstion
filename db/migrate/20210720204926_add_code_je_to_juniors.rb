class AddCodeJeToJuniors < ActiveRecord::Migration[6.1]
  def change
    add_column :juniors, :CodeJE, :string
  end
end
