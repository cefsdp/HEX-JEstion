class Adherent < ApplicationRecord
  belongs_to :user
  has_one :document_adherent, dependent: :destroy
end
