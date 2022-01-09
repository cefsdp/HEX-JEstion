class MandatRequest < ApplicationRecord
  belongs_to :poste
  belongs_to :pole
  belongs_to :membre

  has_one :mandat, dependent: :destroy
end
