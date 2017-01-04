class Api::StepsController < ApplicationController

  def index
    debugger
    @todo = Todo.find(id: params[:todo_id])
    render json: @todo.steps
  end

  def create
    debugger
    @step = Step.new(step_params)
    @step.todo_id = params[:step][:todo_id]
    if @step.save
      render json: @step
    else
      render json: @step.errors.full_messages, status: 422
    end
  end

  def update
    @step = Step.find(params[:step][:id])
    if @step.update(step_params)
      render json: @step
    else
      render json: @step.errors.full_messages, status: 400
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @step.delete
    render json: @step
  end

  private
  def step_params
    params.require(:step).permit(:title, :body, :done)
  end
end
