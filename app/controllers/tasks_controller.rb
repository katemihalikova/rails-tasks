class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.includes([:category, :tags]).page(params[:page])
    parse_group
    sort_tasks
  end

  def completed
    @tasks = current_user.tasks.includes([:category, :tags]).where(is_done: true).page(params[:page])
    parse_group
    sort_tasks
  end

  def pending
    @tasks = current_user.tasks.includes([:category, :tags]).where(is_done: false).page(params[:page])
    parse_group
    sort_tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = current_user.tasks.new
    load_categories_tags
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    @original_task = @task.dup
    load_categories_tags
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task
    else
      load_categories_tags
      render 'new'
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @original_task = @task.dup

    if @task.update(task_params)
      redirect_to @task
    else
      load_categories_tags
      render 'edit'
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
   
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:title, :note, :deadline_at, :is_done, :category_id, tag_ids: [])
  end

  def load_categories_tags
    @categories = current_user.categories
    @tags = current_user.tags
  end

  def parse_group
    @group = params.fetch(:group, 0).to_i
  end

  def sort_tasks
    @tasks = @tasks.order('categories.title ASC') if (@group == 1)
    @tasks = @tasks.order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END ASC, deadline_at ASC')
  end
end
