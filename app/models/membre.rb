class Membre < ApplicationRecord
  belongs_to :membre_request

  has_many :mandat_membres, dependent: :destroy
end
