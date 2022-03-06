class Postulant < ApplicationRecord
  belongs_to :selection_intervenant
  belongs_to :user

  has_many :document_postulants, dependent: :destroy
end
