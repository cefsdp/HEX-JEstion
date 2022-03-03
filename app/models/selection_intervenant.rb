class SelectionIntervenant < ApplicationRecord
  belongs_to :phase

  has_many :postulants, dependent: :destroy
end
