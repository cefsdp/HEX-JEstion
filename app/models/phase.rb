class Phase < ApplicationRecord
  belongs_to :etude

  has_one :selection_intervenant, dependent: :destroy
  has_many :intervenants, dependent: :destroy

  has_many :document_phases, dependent: :destroy
end
