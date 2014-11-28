class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :comments
  has_many :post_votes

  acts_as_votable
  acts_as_commentable

  validates_presence_of :community, :title
end
