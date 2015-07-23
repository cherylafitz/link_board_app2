class PostsController < ApplicationController

  before_action :is_authenticated?, except: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    render layout: false
  end

  def create
    @current_user
    @post = current_user.posts.create post_params
    if @post.persisted?
      # see lenny's code
      redirect_to root_path
    else
      flash[:danger]= @post.errors.full_messages.uniq.to_sentence
      # render :new
      # redirect_to root_path
      redirect_to :back
    end

  end

  def edit
    @post = Post.find params[:id]
    render layout: false
     # = p.create post_params
  end

  def update
    p = Post.find params[:id]
    p.update post_params
    redirect_to root_path
  end

  def show
    @post = Post.find params[:id]
  end

  def destroy
    p = Post.find params[:id]
    # u = p.users
    @current_user = current_user
    if p.user_id == current_user.id
      p.delete
    else
      flash[:danger] = 'Access denied.'
    end
      redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:link,:user_id)
  end

end
