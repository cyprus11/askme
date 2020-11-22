class Question < ApplicationRecord
  belongs_to :user

  validates :text, length: { maximum: 255 }
end
