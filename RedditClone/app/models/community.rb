class Community < ActiveRecord::Base
  has_many :posts
  has_many :community_users
  has_many :users, through: :community_users

  validates :name,
            presence: true,
            length: { in: 3..32 }

  validates :description,
            presence: true,
            length: { maximum: 256 }

  def to_param
    name
  end

end
