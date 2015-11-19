class LessonsController < ApplicationController
  before_action :load_lesson, except: [:create]
  
  def create
    @lesson = Lesson.new lesson_params
    @lesson.user = current_user
    User.not_learned_ids(current_user, @lesson.category).each do |id|
      @lesson.lesson_words.build word_id: id
    end
    @lesson.result = 0
    if @lesson.save
      redirect_to edit_lesson_path(@lesson)
    else
      flash[:info] = t '.info'
      redirect_to categories_path
    end    
  end

  def show
  end
  
  def edit    
  end
  
  def update    
    if @lesson.update_attributes lesson_params
      redirect_to lesson_path(@lesson.id)        
    else      
      render :edit
    end    
  end
  
  private
  def load_lesson
    @lesson = Lesson.find params[:id]    
  end
  
  def lesson_params
    params.require(:lesson).permit :category_id, lesson_words_attributes: [:id, :word_answer_id]
  end  
end