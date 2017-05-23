class Post < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :author, :url, presence: true

end
