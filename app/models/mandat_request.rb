class MandatRequest < ApplicationRecord
  belongs_to :poste
  belongs_to :pole
  belongs_to :membre

  has_many :mandats, dependent: :destroy
end
