class SessionController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    render :new
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user.nil?
      flash[:messages] = "Invalid email"
      redirect_to new_session_url
    else
      if user.is_password?(session_params[:password].to_s)
        log_in_user!(user)
        redirect_to user_url(user)
      else
        flash[:messages] = "Invalid password"
        redirect_to new_session_url
      end
    end
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end

end
