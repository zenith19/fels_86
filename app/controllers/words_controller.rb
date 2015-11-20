class WordsController < ApplicationController
  before_action :logged_in_user
   
  def index
    if params[:learn] == "all" || params[:learn].blank?
      if params["category_id"].blank?
        @words = Word.all.paginate page: params[:page]
      else
        category = Category.find params["category_id"]
        @words = category.words.paginate page: params[:page]
      end
    elsif params[:learn] == "learned"
      if params["category_id"].blank?
        if current_user.words.blank?
          flash[:danger] = t :didnt_learn
          @words = nil
        else
          @words = current_user.words.paginate page: params[:page]
        end
      else
        if current_user.words.blank?
          flash[:danger] = t :didnt_learn
          @words = nil
        else
          category = Category.find params["category_id"]
          if current_user.words.find_by(category_id: category.id).blank?
            flash[:danger] = t :didnt_learn_category
            @words = nil
          else
            @words = current_user.words.find_word_objects(category).paginate page: params[:page]
          end
        end
      end
    else
      if params["category_id"].blank?
        @words = Word.not_learn_all_categories(current_user).paginate page: params[:page]
      else
        category = Category.find params["category_id"]
        @words = Word.not_learned_specific_category(current_user,category).paginate page: params[:page]
        if @words.blank?
          flash[:danger] = t :learn_all_category
        end
      end
    end
  end
  
end