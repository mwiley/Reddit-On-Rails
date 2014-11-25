class PostVotes < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
