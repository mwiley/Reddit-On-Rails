class Community < ActiveRecord::Base
  has_many :posts
  has_many :community_users
  has_many :users, through: :community_users

  def to_param
    name
  end
end
