class DocumentPhase < ApplicationRecord
  belongs_to :phase

  has_one_attached :document
  has_one_attached :generated_document
end
