class SessionsController < ApplicationController
  before_action :dont_let_signup, only: [:create, :new], if: -> { current_user }

  def new
  end

  def create
    user = User.find_by_credentials(session_params[:user_name], session_params[:password])

    if user
      user.reset_session_token!
      log_in(user)
      flash[:messages] = ["Welcome Back. Rent a cat!"]
      redirect_to cats_url
    else
      flash.now[:messages] = ["Go away. No cats for you."]
      render :new
    end
  end

  def destroy
    log_out if current_user
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end
