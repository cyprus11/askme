class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def find_hashtag(hashtag)
    Hashtag.find_by_text(hashtag.downcase)
  end
end
