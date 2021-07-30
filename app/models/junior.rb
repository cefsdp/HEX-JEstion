class Junior < ApplicationRecord
  validates_presence_of :codeje, on: :create, message: "Vous devez avoir un code"
  validates_uniqueness_of :codeje, on: :create, message: "Ce code ne peut être utilisé"

  has_many :users, dependent: :destroy

  has_one_attached :logo

  has_one :configuration
end
