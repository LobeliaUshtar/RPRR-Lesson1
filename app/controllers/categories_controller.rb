class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
  end
  
  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "The new category was created."
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "This category was updated."
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find_by slug: params[:id]
    end
  # private end
end