class Adherent < ApplicationRecord
  belongs_to :user
  has_one :document_adherent, dependent: :destroy

  has_one_attached :avatar
  delegate :junior, to: :user
end
