json.array!(@post_votes) do |post_vote|
  json.extract! post_vote, :id, :upvote, :user_id, :post_id
  json.url post_vote_url(post_vote, format: :json)
end
