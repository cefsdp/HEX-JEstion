class DocumentIntervenant < ApplicationRecord
  belongs_to :intervenant

  has_one_attached :document
  has_one_attached :generated_document
end
