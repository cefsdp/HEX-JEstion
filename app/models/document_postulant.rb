class DocumentPostulant < ApplicationRecord
  belongs_to :postulant

  has_one_attached :document
  has_one_attached :generated_document
end
