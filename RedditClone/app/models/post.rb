class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :comments
  acts_as_votable
  acts_as_commentable

  validates :community, presence: true
  validates :title,
            presence: true,
            length: { maximum: 128 }

  max_paginates_per 20

  # add a like for the creator of the post
  after_save 'self.liked_by self.user'

  # gets the net votes for the post
  def total_votes
    self.get_upvotes.size - self.get_downvotes.size
  end

  # Upvotes for the current user, or removes vote if already upvoted
  def upvote(current_user)
    if current_user && current_user.voted_up_on?(self)
      self.unliked_by current_user
    else
      self.liked_by current_user
    end
  end

  # Downvotes for the current user, or removes vote if already downvoted
  def downvote(current_user)
    if current_user && current_user.voted_down_on?(self)
      self.undisliked_by current_user
    else
      self.downvote_by current_user
    end
  end

  # gets the posts that belong to a community the user subscribes to
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

  def self.sort(posts, sortby)
    if sortby == 'votes'
      posts.to_a.sort_by! { |post| post.total_votes }
    else
      posts.to_a.sort_by! { |post| post.created_at }
    end
  end

end
