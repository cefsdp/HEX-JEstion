class Membre < ApplicationRecord
  belongs_to :membre_request
  delegate :user, to: :membre_request, allow_nil: true

  has_many :mandat_requests, dependent: :destroy
  has_many :mandats, through: :mandat_requests
  has_many :permissions, through: :mandats
end
