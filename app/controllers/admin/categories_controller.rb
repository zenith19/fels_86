class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin
  
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      flash[:notice] = t '.success'
      redirect_to admin_categories_path
    else
      render :new
    end
  end
  
  def edit
    @category = Category.find params[:id]
  end
  
  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      flash[:notice] = t '.success'
      redirect_to admin_categories_path
    else
      render :edit
    end
  end
  
  private
  def category_params
    params.require(:category).permit :name
  end
end