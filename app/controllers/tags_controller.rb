class TagsController < ApplicationController
  def index
    @tags = current_user.tags.order(:title)
  end

  def show
    @tag = current_user.tags.find(params[:id])
    @tasks = @tag.tasks.includes([:category, :tags_tasks, :tags]).order('CASE WHEN deadline_at IS NULL THEN 1 ELSE 0 END ASC, deadline_at ASC').page(params[:page])
  end

  def new
    @tag = current_user.tags.new(color: helpers.random_color)
    save_previous_page
  end

  def edit
    @tag = current_user.tags.find(params[:id])
    @original_tag = @tag.dup
    save_previous_page
  end

  def create
    @tag = current_user.tags.new(tag_params)

    if @tag.save
      redirect_before_form fallback_location: @tag, flash: {success: "Tag byl úspěšně přidán."}
    else
      render 'new'
    end
  end

  def update
    @tag = current_user.tags.find(params[:id])
    @original_tag = @tag.dup

    if @tag.update(tag_params)
      redirect_before_form fallback_location: @tag, flash: {success: "Tag byl úspěšně upraven."}
    else
      render 'edit'
    end
  end

  def destroy
    @tag = current_user.tags.find(params[:id])
    @tag.destroy

    redirect_to tags_path, flash: {success: "Tag byl úspěšně smazán."}
  end

  private
  def tag_params
    params.require(:tag).permit(:title, :color)
  end
end
