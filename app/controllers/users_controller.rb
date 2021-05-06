class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
    @hashtags = Hashtag.with_questions
  end

  def new
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновленны'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @background_color = "background:#{@user.color}"
    @word_forms = %w[вопрос вопроса вопросов]
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    @user.destroy

    session[:user_id] = nil
    redirect_to root_path, notice: 'Пользователь удален'
  end

  private

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :color, :password_confirmation,
                                 :name, :username, :avatar_url)
  end

  def authorize_user
    reject_user unless @user == current_user
  end
end
