class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.order(:title)
  end

  def show
    @category = current_user.categories.find(params[:id])
    @tasks = @category.tasks.page(params[:page])
  end

  def new
    @category = current_user.categories.new(color: helpers.random_color)
  end

  def edit
    @category = current_user.categories.find(params[:id])
    @original_category = @category.dup
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to @category, flash: {success: "Kategorie byla úspěšně přidána."}
    else
      render 'new'
    end
  end

  def update
    @category = current_user.categories.find(params[:id])
    @original_category = @category.dup
   
    if @category.update(category_params)
      redirect_to @category, flash: {success: "Kategorie byla úspěšně upravena."}
    else
      render 'edit'
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy
   
    redirect_to categories_path, flash: {success: "Kategorie byla úspěšně smazána."}
  end

  private
  def category_params
    params.require(:category).permit(:title, :color)
  end
end
