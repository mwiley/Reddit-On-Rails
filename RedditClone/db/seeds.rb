# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(
    email: "masonwiley92@gmail.com",
    password: "391812a",
    password_confirmation: "391812a"
)
user.save!

communities = [
    {name: 'pics', private: 'false', default: 'true'},
    {name: 'videos', private: 'false', default: 'true'},
    {name: 'funny', private: 'false', default: 'true'},
    {name: 'gifs', private: 'false', default: 'true'},
    {name: 'wtf', private: 'false', default: 'true'}
]

posts = [
    {title: 'test', user_id: 1, community_id: 1, url: "http://google.com", text:"testing"}
]

communities.each do |c|
  Community.create(c).save
end

posts.each do |p|
 Post.create(p).save
end