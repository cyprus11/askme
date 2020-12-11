class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, except: [:create]
  before_action :remove_hashtags, only: [:update]

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      find_and_create_tags
      redirect_to user_path(@question.user), notice: 'Вопрос задан.'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params)
      find_and_create_tags
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен.'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    remove_hashtags
    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос успешно удален.'
  end

  private
  def remove_hashtags
    tags = @question.hashtags
    tags.each do |tag|
      @question.hashtags.delete(tag)
      tag.destroy unless tag.questions.any?
    end
  end

  def find_and_create_tags
    tags_regex = /#[[:word:]]+/
    tags = @question.text.scan(tags_regex)
    tags += @question.answer.scan(tags_regex) unless @question.answer.nil?
    tags.each do |tag|
      find_result = Hashtag.find_by_text(tag.downcase)
      if find_result.nil?
        @question.hashtags.create!(text: tag)
      else
        @question.hashtags << find_result
      end
    end
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def question_params
    if current_user.present? && params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end
end
