class Membre < ApplicationRecord
  belongs_to :junior
  belongs_to :user
end
