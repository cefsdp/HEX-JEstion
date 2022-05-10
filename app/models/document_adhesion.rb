class DocumentAdhesion < ApplicationRecord
  belongs_to :adherent

  has_one_attached :document
  has_one_attached :generated_document
end
