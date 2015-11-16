class CategoriesController < ApplicationController
  before_action :logged_in_user
  
  def index
    @categories = Category.all
    @lesson = Lesson.new    
  end
end