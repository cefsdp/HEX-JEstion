class Membre < ApplicationRecord
  belongs_to :membre_request

  has_many :mandat_requests, dependent: :destroy
  has_many :mandats, through: :mandat_requests
end
