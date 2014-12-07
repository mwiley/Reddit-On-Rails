class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :comments
  has_many :post_votes

  acts_as_votable
  acts_as_commentable

  validates_presence_of :community, :title

  def self.subscriptions(user)
    Post.joins(:community)
        .joins('INNER JOIN community_users ON posts.community_id = community_users.community_id')
        .where(communities: {default: true})
        .where.not(community_users: {user_id: user.id, subscriber: false}) &&

    Post.joins('INNER JOIN community_users ON posts.community_id = community_users.community_id')
        .where(community_users: {user_id: user.id, subscriber: true})
  end
end
