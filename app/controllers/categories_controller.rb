class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def show
    @category = current_user.categories.find(params[:id])
  end

  def new
    @category = current_user.categories.new
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    @category = current_user.categories.find(params[:id])
   
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy
   
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:title, :color)
  end
end
