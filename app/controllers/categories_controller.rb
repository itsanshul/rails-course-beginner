class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category Added Succesfully"
      redirect_to categories_path
    end
  end

  def edit
      @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Name Updated Successfully"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @category.destroy
      flash[:success] = "Category Deleted Successfully"
      redirect_to categories_path
  end
  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only Admins can perform this action"
      redirect_to  categories_path
    end
  end

end