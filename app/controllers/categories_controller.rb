class CategoriesController < ApplicationController
  def index

  end

  def new

  end

  def create

  end

  def show
    @category = User.find(params[:id])
  end


end