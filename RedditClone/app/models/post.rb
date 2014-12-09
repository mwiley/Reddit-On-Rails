class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :comments

  acts_as_votable
  acts_as_commentable

  validates_presence_of :community, :title

  max_paginates_per 20

  def self.subscriptions(user)
    if user
      (Post.joins(:community)
          .where(communities: {default: true}) +
       Post.joins('INNER JOIN community_users ON posts.community_id = community_users.community_id')
          .where(community_users: {user_id: user.id, subscriber: true}) -
       Post.joins('INNER JOIN community_users ON posts.community_id = community_users.community_id')
          .where(community_users: {user_id: user.id, subscriber: false})
      ).uniq
    else
      Post.joins(:community)
          .where(communities: {default: true})
    end
  end
end
