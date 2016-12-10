class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(session_params[:username], session_params[:password])

    if user.nil?
      flash.now[:errors] = ["unable to login"]
      render :new
    else
      sign_in(user)
      redirect_to subs_url
    end

  end

  def new
    render :new
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
