class TresoreriesController < ApplicationController
  def index
    @tresoreries = policy_scope(Tresorerie)
  end
end
