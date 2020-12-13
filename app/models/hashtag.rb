class Hashtag < ApplicationRecord
  HASHTAG_REGEX = /#[[:word:]]+/

  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions

  validates :text, format: { with: HASHTAG_REGEX }
  validates :text, length: { minimum: 2 }
  validates :text, length: { maximum: 40 }

  before_save :downcase_text

  private

  def downcase_text
    text.downcase!
  end
end

