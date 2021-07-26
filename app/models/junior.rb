class Junior < ApplicationRecord
  validates_presence_of :CodeJE, on: :create, message: "Vous devez avoir un code"
  validates_uniqueness_of :CodeJE, on: :create, message: "Ce code ne peut être utilisé"
end
