class Junior < ApplicationRecord
  validates_presence_of :codeje, on: :create, message: "Vous devez avoir un code"
  validates_uniqueness_of :codeje, on: :create, message: "Ce code ne peut être utilisé"

  has_many :users, dependent: :destroy
  has_many :membre_requests, dependent: :destroy
  has_many :membres, dependent: :destroy
  has_many :adherents, through: :users

  has_one :junior_configuration
  has_many :config_doc_adherents, through: :junior_configuration
end
