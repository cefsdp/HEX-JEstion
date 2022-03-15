class DocumentPostulant < ApplicationRecord
  belongs_to :postulant

  has_one_attached :document
end
