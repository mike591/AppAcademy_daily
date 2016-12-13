class GoalsController < ApplicationController
  before_action :require_login

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.cheers = 0
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def index
    @goals = current_user.goals
  end

  def edit

  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.finished.nil?
      @goal.finished = "true"
    else
      @goal.finished = nil
    end
    @goal.save
    flash[:success] = "Goal updated"
    redirect_to goal_url(@goal)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user_id)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :details, :visibility, :finished)
  end
end
