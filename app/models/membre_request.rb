class MembreRequest < ApplicationRecord
  belongs_to :junior
  belongs_to :user
  has_one :membre
end
