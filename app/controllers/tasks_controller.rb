class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[edit update destroy]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Your task successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task has been deleted.'
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end

  def set_task
    @task = Task.find(params[:id])
    validate_permissions(@task)
  end

  def validate_permissions(task)
    return if current_user&.author_of?(task)

    redirect_to tasks_path, alert: 'You are not authorized to perform this action.'
  end
end
