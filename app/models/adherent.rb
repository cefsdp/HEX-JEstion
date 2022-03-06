class Adherent < ApplicationRecord
  belongs_to :user
  has_many :document_adhesions, dependent: :destroy
  has_many :document_adherents, dependent: :destroy

  has_one_attached :avatar
  delegate :junior, to: :user
end
