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
end
