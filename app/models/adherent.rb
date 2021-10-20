class Adherent < ApplicationRecord
  belongs_to :user
  has_one :document_adherent, dependent: :destroy

  delegate :junior, to: :user
end
