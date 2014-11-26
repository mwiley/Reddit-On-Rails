class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :comments
  has_many :post_votes

  validates_presence_of :community, :title
end
