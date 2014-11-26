class User < ActiveRecord::Base
  # Include default devise modules. Ot
  # hers available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :community_users
  has_many :communities, through: :community_users

  def subscribed
    Post.joins('LEFT OUTER JOIN community_users ON posts.community_id = community_users.community_id')
  end
end
