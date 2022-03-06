class DocumentAdherent < ApplicationRecord
  belongs_to :adherent

  has_one_attached :document
end
