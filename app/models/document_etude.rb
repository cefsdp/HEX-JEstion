class DocumentEtude < ApplicationRecord
  belongs_to :etude

  has_one_attached :document
end
