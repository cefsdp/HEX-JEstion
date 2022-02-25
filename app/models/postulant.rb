class Postulant < ApplicationRecord
  belongs_to :selection_intervenant
  belongs_to :user
end
