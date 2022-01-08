class MembresController < ApplicationController
  before_action :authenticate_user!

  def index
    @membres = policy_scope(Membre)
    @request_membres = policy_scope(MembreRequest)
    @request_mandats = policy_scope(MandatRequest)
  end
end
