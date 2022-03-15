class DocumentPhase < ApplicationRecord
  belongs_to :phase

  has_one_attached :document
end
