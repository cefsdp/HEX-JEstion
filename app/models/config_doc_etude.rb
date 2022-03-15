class ConfigDocEtude < ApplicationRecord
  belongs_to :junior_configuration

  has_one_attached :document_type
end
