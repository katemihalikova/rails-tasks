class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.includes([:category, :tags]).page(params[:page])
    load_categories include_no_category: true
    load_tags
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

  def filter
    category = params[:filter][:category] unless params[:filter][:category] == ""
    tags = params[:filter][:tags]
    if category && tags
      redirect_to tasks_by_category_and_tags_path(category, tags.join(','))
    elsif tags
      redirect_to tasks_by_tags_path(tags.join(','))
    elsif category
      redirect_to tasks_by_category_path(category)
    else
      redirect_to tasks_path
    end
  end

  def by_category
    @category = params[:category_id] == "0" ? nil : current_user.categories.find(params[:category_id])
    @tasks = current_user.tasks.includes([:category, :tags]).where(category: @category).page(params[:page])
    load_tags
    parse_group
    sort_tasks
  end

  def by_tags
    tag_ids = params[:tag_ids].split(',').map(&:to_i)
    @tags = current_user.tags.find(tag_ids)
    @tasks = current_user.tasks.includes([:category, :tags]).where('tags.id': @tags).page(params[:page])
    load_categories include_no_category: true
    parse_group
    sort_tasks
  end

  def by_category_and_tags
    @category = params[:category_id] == "0" ? nil : current_user.categories.find(params[:category_id])
    tag_ids = params[:tag_ids].split(',').map(&:to_i)
    @tags = current_user.tags.find(tag_ids)
    @tasks = current_user.tasks.includes([:category, :tags]).where(category: @category, 'tags.id': @tags).page(params[:page])
    parse_group
    sort_tasks
  end

  def search
    if params[:search]
      redirect_to tasks_search_path(params[:search][:keyword])
    else
      @keyword = params[:keyword]
      @tasks = current_user.tasks.includes([:category, :tags]).where("title LIKE ? OR note LIKE ?", "%#{@keyword}%", "%#{@keyword}%").page(params[:page])
      sort_tasks
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = current_user.tasks.new
    load_categories
    load_tags
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    @original_task = @task.dup
    load_categories
    load_tags
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task
    else
      load_categories
      load_tags
      render 'new'
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @original_task = @task.dup

    if @task.update(task_params)
      redirect_to @task
    else
      load_categories
      load_tags
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

  def load_categories(opts = {})
    @categories = current_user.categories.order(:title)
    @categories = [Category.new({id: 0, title: "(žádná kategorie)"})] + @categories if opts[:include_no_category]
  end

  def load_tags
    @tags = current_user.tags.order(:title)
  end

  def parse_group
    @group = params.fetch(:group, 0).to_i
  end

  def sort_tasks
    @tasks = @tasks.order('categories.title ASC') if (@group == 1)
    @tasks = @tasks.order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END ASC, deadline_at ASC')
  end
end
