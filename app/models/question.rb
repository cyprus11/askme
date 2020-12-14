class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtags_questions, dependent: :destroy
  has_many :hashtags, through: :hashtags_questions

  validates :text, length: { maximum: 255 }
  validates :text, presence: true, on: :create
  after_save_commit :find_and_create_tags
  before_update :remove_hashtags
  before_destroy :remove_hashtags, prepend: true

  private

  def remove_hashtags
    hashtags.each do |tag|
      hashtags.delete(tag)
      tag.destroy unless tag.questions.any?
    end
  end

  def find_and_create_tags
    tags = text.scan(Hashtag::HASHTAG_REGEX) |
           (answer&.scan(Hashtag::HASHTAG_REGEX) || [])

    tags.each do |tag|
      new_tag = Hashtag.find_or_create_by(text: tag.downcase)
      hashtags << new_tag unless hashtags.include?(new_tag)
    end
  end
end
