class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      flash.now[:error] = "Post could not be created!"
      render :new, status: :unprocessable_entity
    end
  end

  private
    def post_params
      params.expect(post: [ :body ])
    end
end
