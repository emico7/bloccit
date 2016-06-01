class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index do |post, index|
      if index == 0
        post.update(title: "SPAM")
      elsif index % 5 == 4
        post.update(title: "SPAM")
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
