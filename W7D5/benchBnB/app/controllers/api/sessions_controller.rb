class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      log_in(@user)
      render :show
    else
      render json: ["Invalid credentials"], status: 400
    end
  end

  def destroy
    if current_user
      log_out
      render json: {}
    else
      render json: ['Not currently logged in'], status: 404
    end
  end
end
