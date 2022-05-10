class DocumentEtude < ApplicationRecord
  belongs_to :etude

  has_one_attached :document
  has_one_attached :generated_document
end
