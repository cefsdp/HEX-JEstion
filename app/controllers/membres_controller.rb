class MembresController < ApplicationController
  before_action :authenticate_user!

  def index
    @junior = Junior.find(junior_id_params.to_i)
    @membres = policy_scope(Membre)
    @request_membres = policy_scope(MembreRequest)
    @request_mandats = policy_scope(MandatRequest)
  end

  private

  def junior_id_params
    params.require(:junior_id)
  end
end
