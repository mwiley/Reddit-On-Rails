class PostVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  acts_as_voter

  def self.total_votes(post)
    post.post_votes.size
  end
end
