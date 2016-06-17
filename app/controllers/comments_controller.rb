class CommentsController < ApplicationController

  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create

    if params[:post_id]
      @post = Post.find(params[:post_id])
      comment = @post.comments.new(comment_params)
      comment.user = current_user

      if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to [@post.topic, @post]
      elsif
        flash[:alert] = "Comment failed to save."
        redirect_to [@post.topic, @post]
      end

    elsif params[:topic_id]
      @topic = Topic.find(params[:topic_id])
      comment = @topic.comments.new(comment_params)
      comment.user = current_user

      if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to [@topic]
      else
        flash[:alert] = "Comment failed to save."
        redirect_to [@topic]
      end
    end

  end

  def destroy

      comment = Comment.find(params[:id])


      if comment.destroy
        flash[:notice] = "Comment was deleted successfully."
      else
        flash[:alert] = "Comment couldn't be deleted. Try again."
      end

      if params[:post_id]
        @post = Post.find(params[:post_id])
        redirect_to [@post.topic, @post]
      elsif params[:topic_id]
        @topic = Topic.find(params[:topic_id])
        redirect_to [@topic]
      end

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delte a comment."

      if params[:post_id]
        redirect_to [comment.post.topic, comment.post]
      elsif params[:topic_id]
        redirect_to [comment.topic, comment.topic]
      end
    end
  end
end
