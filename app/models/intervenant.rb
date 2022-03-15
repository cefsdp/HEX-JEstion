class Intervenant < ApplicationRecord
  belongs_to :phase
  belongs_to :user

  has_many :document_intervenants, dependent: :destroy
end
