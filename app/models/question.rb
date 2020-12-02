class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, length: { maximum: 255 }
  validates :text, presence: true, on: :create
  validates :answer, presence: true, on: :update
end
