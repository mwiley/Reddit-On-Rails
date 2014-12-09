# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

USER_COUNT = 20
COMMUNITY_COUNT = 6

User.new(
    email: "masonwiley92@gmail.com",
    password: "a",
    password_confirmation: "a"
).save

for i in 1..USER_COUNT do
  User.new(
          email: Faker::Internet.email,
          password: 'a',
          password_confirmation: 'a',
  ).save
end

communities = [
    {name: 'pics', private: 'false', default: 'true'},
    {name: 'videos', private: 'false', default: 'true'},
    {name: 'funny', private: 'false', default: 'true'},
    {name: 'gifs', private: 'false', default: 'true'},
    {name: 'wtf', private: 'false', default: 'true'},
    {name: 'metal', private: 'false', default: 'false'}
]

communities.each do |c|
  Community.create(c).save
end

for post_id in 0..100 do
  user = (1..USER_COUNT).to_a.sample
  post = Post.new(
          title: Faker::Lorem.sentence,
          url: Faker::Internet.url,
          text: Faker::Lorem.paragraph,
          user_id: user,
          community_id: (1..COMMUNITY_COUNT).to_a.sample
  )
  post.save!
  post.liked_by(User.find(user))

  for i in 2..20 do
    if rand(100) > 40
      post.liked_by User.find(i)
    else
      post.downvote_by User.find(i)
    end
  end

  for i in 1..rand(20)
    Comment.new(
          body: Faker::Lorem.paragraph,
          commentable_id: post_id,
          commentable_type: 'Post',
          user_id: (1..USER_COUNT).to_a.sample
    ).save
  end
end
