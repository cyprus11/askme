class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Вы успешно вошли'
    else
      flash.now.alert = 'Неправильные данные для входа'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Вы вышли, приходите ещё'
  end
end
