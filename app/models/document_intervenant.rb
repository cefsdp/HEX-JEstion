class DocumentIntervenant < ApplicationRecord
  belongs_to :intervenant

  has_one_attached :document
end
