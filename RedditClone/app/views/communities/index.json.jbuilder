json.array!(@communities) do |community|
  json.extract! community, :id, :name, :private
  json.url community_url(community, format: :json)
end
