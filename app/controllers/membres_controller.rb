class MembresController < ApplicationController
  before_action :authenticate_user!

  def index
    @membres = policy_scope(Membre)
  end
end
