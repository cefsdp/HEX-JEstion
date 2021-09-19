class JuniorConfiguration < ApplicationRecord
  belongs_to :junior

  has_one_attached :logo
end
