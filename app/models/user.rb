class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_token_authenticatable

  belongs_to :junior

  has_one :membre_request, dependent: :destroy
  has_one :userparam, dependent: :destroy
  has_one :membre, through: :membre_request
  has_many :mandat_requests, through: :membre
  has_many :mandats, through: :mandat_requests
  has_one :adherent, dependent: :destroy
  has_one :document_adhesion, through: :adherent
  has_many :postulants, dependent: :destroy
  has_many :intervenants, dependent: :destroy
end
