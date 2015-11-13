class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :load_object, except: [:index, :new, :create]
  before_action :build_object, only: [:new, :create]
  
  def index
    @words = Word.paginate page: params[:page]
  end

  def new
    4.times {@word.word_answers.build}
  end

  def create    
    if @word.save
      flash[:notice] = t '.success'
      redirect_to admin_words_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:notice] = t '.success'
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    flash[:notice] = t '.success'
    redirect_to admin_words_path
  end

  private
  def load_object
    @word = Word.find params[:id]
    @categories = Category.all
  end
  
  def build_object
    @word = request.post? ? Word.new(word_params) : Word.new
    @categories = Category.all
  end
  
  def word_params
    params.require(:word).permit :content, :category_id, 
      word_answers_attributes: [:id, :content, :correct]
  end  
end