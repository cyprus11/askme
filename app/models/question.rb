class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtags_questions
  has_many :hashtags, through: :hashtags_questions

  validates :text, length: { maximum: 255 }
  validates :text, presence: true, on: :create
  validates :answer, presence: true, on: :update
  after_save :find_and_create_tags
  after_update :find_and_create_tags
  before_destroy :remove_hashtags

  private

  def remove_hashtags
    tags = hashtags
    tags.each do |tag|
      hashtags.delete(tag)
      tag.destroy unless tag.questions.any?
    end
  end

  def find_and_create_tags
    tags_regex = /#[[:word:]]+/
    text_tags = text.scan(tags_regex)
    answer_tags = []
    answer_tags = answer.scan(tags_regex) unless answer.nil?
    (text_tags | answer_tags).each do |tag|
      find_result = find_hashtag(tag)
      if find_result.nil?
        hashtags.create!(text: tag)
      else
        hashtags << find_result unless hashtags.include?(find_result)
      end
    end
  end
end
