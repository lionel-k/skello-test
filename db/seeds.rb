require_relative 'database.rb'

DB.each do |post|
  Post.create(post)
end

COMMENTS.each_with_index do |comments, index|
  comments.each do |comment|
    new_comment = Comment.new(body: comment)
    new_comment.post = Post.find(index + 1)
    new_comment.save
  end
end
