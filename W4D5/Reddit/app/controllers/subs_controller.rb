class SubsController < ApplicationController
  before_action :require_moderator, only: [:edit, :update]

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def index
    render :index
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def require_moderator
    sub = Sub.find_by(id: params[:id])
    redirect_to subs_url unless current_user == sub.moderator
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end


end
