class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: "https://avatars.mds.yandex.net/get-kino-vod-films-gallery/28788/47e2fd514411e18b76af786d7417062d/280x178_2"
      ),

      User.new(
        id: 2,
        name: 'Misha',
        username: 'misha'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vadim',
      username: 'installero',
      avatar_url: "https://avatars.mds.yandex.net/get-kino-vod-films-gallery/28788/47e2fd514411e18b76af786d7417062d/280x178_2"
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('23.11.2020')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('23.11.2020'))
    ]

    @new_question = Question.new
  end
end
