class CategoriesController < ApplicationController
  before_action :logged_in_user
  
  def index
    @categories = Category.all
  end
end