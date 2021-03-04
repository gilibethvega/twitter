class HomeController < ApplicationController
  def index
  end
  def users
    @users = User.all
    if current_user.present?
      @following = current_user.users_followed
    else
      redirect_to new_user_session_path
    end
  end

end
