class CreateGeneratedDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :generated_documents do |t|
      t.string :type_document

      t.timestamps
    end
  end
end
