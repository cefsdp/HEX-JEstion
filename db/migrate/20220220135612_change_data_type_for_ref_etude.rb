class ChangeDataTypeForRefEtude < ActiveRecord::Migration[6.1]
  def change
    change_column :etudes, :ref_etude, 'integer USING CAST(ref_etude AS integer)'
  end
end
