class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]
  before_action :set_question, only: [:create]

  def index
    @hashtags = Hashtag.all
  end

  def show
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find(params[:id])
  end
end
