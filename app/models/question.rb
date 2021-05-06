class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :hashtags_questions, dependent: :destroy
  has_many :hashtags, through: :hashtags_questions

  validates :text, length: { maximum: 255 }
  validates :text, presence: true, on: :create
  after_save_commit :find_and_create_tags

  private

  def find_and_create_tags
    hashtags.clear
    tags = "#{text} #{answer}".downcase.scan(Hashtag::HASHTAG_REGEX).uniq

    tags.each do |tag|
      hashtags << Hashtag.find_or_create_by(text: tag)
    end
  end
end
