class JuniorConfiguration < ApplicationRecord
  belongs_to :junior

  has_many :config_doc_adherents, dependent: :destroy

  has_one_attached :logo
end