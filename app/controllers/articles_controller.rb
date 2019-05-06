class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
      if @article.save
        flash[:success] = "Article Successfully Created"
        redirect_to article_path(@article)
      else
        render 'new'
      end
    end

  def update
      if @article.update(article_params)
        flash[:success] = "Article Updated"
        redirect_to article_path
      else
        render 'edit'
      end
    end

  def destroy
    @article.destroy
    flash[:danger] = "Article Delete Success"
    redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only edit/delete your articles"
        redirect_to root_path
      end
    end
end
