class Etude < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :prestation
  belongs_to :charge_etude, class_name: 'User'
  belongs_to :charge_qualite, class_name: 'User', optional: true
  belongs_to :charge_rh, class_name: 'User', optional: true
  belongs_to :junior
end
