class CommentsController < ApplicationController
  def index
  end
  def new
    @comment = Comment.new
    render layout: false
  end
  def create
    @comment = current_user.comments.create comment_params
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body,:post_id,:user_id)
  end

end
