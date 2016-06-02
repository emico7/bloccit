require 'random_data'

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

unique_post = Post.find_or_create_by!(
  title: "Unique Title", body: "This post should be added only once. This is for checkpoint 30."
)

Comment.find_or_create_by!(
  post: unique_post,
  body: "This comment belongs to the unique post. This is for assignment 30."
)

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
