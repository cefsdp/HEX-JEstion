class Mandat < ApplicationRecord
  belongs_to :mandat_request
  belongs_to :permission
end
