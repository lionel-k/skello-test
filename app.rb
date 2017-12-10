require "sinatra"
require "sinatra/reloader" if development?

require 'sinatra/activerecord'
require './config/environments'

class Post < ActiveRecord::Base
  has_many :comments
  scope :ordered_by_ratings, -> { order(rating: :desc) }

  def upvote!
    self.rating += 1
  end
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

get "/" do
  if params[:query].present?
    @posts = Post.includes(:comments).where("title ILIKE ?", "%#{params[:query]}%")
  else
    @posts = Post.includes(:comments).ordered_by_ratings
  end

  @title = "Welcome"
  erb :posts
end

get "/posts/new" do
 @title = "Create a new post"
 @post = Post.new
 erb :new
end

get "/posts/:id" do
 @post = Post.find(params[:id])
 @title = @post.title
 @comments = @post.comments.order("created_at DESC")
 erb :show
end

post "/posts" do
 @post = Post.new(params[:post])
 if @post.save
   redirect "/"
 else
   erb :new
 end
end

get '/posts/:id/upvote' do
  id = params[:id]
  post = Post.find(id)
  post.upvote!
  post.save
  redirect "/"
end

post '/posts/:id/comments' do
  id = params[:id]
  post = Post.find(id)
  comment = Comment.new(params[:comment])
  comment.post = post
  comment.save
  redirect "posts/#{post.id}"
end

