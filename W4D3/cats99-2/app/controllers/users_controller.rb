class UsersController < ApplicationController
  before_action :dont_let_signup, only: [:create, :new], if: -> { current_user }

  def create
    @user = User.new(user_params)
    if @user.save!
      log_in(@user)
      redirect_to cats_url
    else
      flash[:message] = ["Invalid sign up :("]
      redirect_to new_user_url
    end
  end

  def new
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
