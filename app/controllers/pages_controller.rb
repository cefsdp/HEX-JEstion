class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # raise
    if current_user.nil?
      redirect_to new_user_session_path
    else
      redirect_to junior_path(current_user.junior)
    end
  end
end
