class AddArchiveToPole < ActiveRecord::Migration[6.1]
  def change
    add_column :poles, :achive, :boolean
  end
end
