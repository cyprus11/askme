class Hashtag < ApplicationRecord
  HASHTAG_REGEX = /#[[:word:]]+/

  has_and_belongs_to_many :questions

  validates :text, format: { with: HASHTAG_REGEX }
  validates :text, length: { minimum: 2 }
  validates :text, length: { maximum: 40 }

  before_save :downcase_text

  private

  def downcase_text
    text.downcase!
  end
end

