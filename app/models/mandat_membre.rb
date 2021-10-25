class MandatMembre < ApplicationRecord
  belongs_to :membre
  belongs_to :pole
  belongs_to :poste
end
