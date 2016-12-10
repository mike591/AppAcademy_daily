class PostsController < ApplicationController
  before_action :require_author, only: [:update, :edit, :destroy]

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def show
    @post = Post.find_by(id: params[:id])
    @all_comments = @post.comments.includes(:author)
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  # def destroy
  #
  # end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_author
    @post = Post.find_by(id: params[:id])
    redirect_to sub_url(@post.sub) unless @post.author == current_user
  end
end
