class TagsController < ApplicationController
  def index
    @tags = current_user.tags
  end

  def show
    @tag = current_user.tags.find(params[:id])
  end

  def new
    @tag = current_user.tags.new
  end

  def edit
    @tag = current_user.tags.find(params[:id])
  end

  def create
    @tag = current_user.tags.new(tag_params)

    if @tag.save
      redirect_to @tag
    else
      render 'new'
    end
  end

  def update
    @tag = current_user.tags.find(params[:id])
   
    if @tag.update(tag_params)
      redirect_to @tag
    else
      render 'edit'
    end
  end

  def destroy
    @tag = current_user.tags.find(params[:id])
    @tag.destroy
   
    redirect_to tags_path
  end

  private
  def tag_params
    params.require(:tag).permit(:title, :color)
  end
end
