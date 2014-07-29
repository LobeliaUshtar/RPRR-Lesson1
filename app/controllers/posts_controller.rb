class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by{ |x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "The new post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Successfully voted..."
        else
          flash[:error] = "You can only vote on a post once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
      # params.require(:post).permit!
    end

    def set_post
      @post = Post.find_by slug: params[:id]
    end
  # private end
end