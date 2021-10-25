class ChangeAchivePole < ActiveRecord::Migration[6.1]
  def change
    rename_column :poles, :achive, :archive
  end
end
