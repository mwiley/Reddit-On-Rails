class User < ActiveRecord::Base
  # Include default devise modules. Ot
  # hers available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter

  validates :email, presence: true

  has_many :community_users
  has_many :communities, through: :community_users

  def subscribed?(community)
    community_user = self.community_users.where(community_id: community.id).first_or_create
    if community_user.subscriber
      true
    elsif community_user.subscriber == nil
      true if community.default
    else
      false
    end
  end

  def update_subscription(community)
    community_user = self.community_users.where(community_id: community.id).first_or_create
    # reverse the subscription status
    community_user.subscriber = !community_user.subscriber
    community_user.save!
  end

end
