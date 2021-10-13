class PostsController < ApplicationController
  require 'set'
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :logged_in

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def feed
    @follow = Set.new([@user.id])         #set of all followee include user himself
    @pos = []
    Follow.find_each do |fol|             #find all follower and put them in set
      if (fol.follower_id == @user.id)
        @follow.add(fol.followee_id)
      end
    end
    Post.order("created_at DESC").each do |post|   #get all post sort by time(newest first)
      if (@follow.member?(post.user_id))
        @pos.push(post.id)
      end
    end

    puts @follow
    puts @pos
  end

  def nPost
    @post = Post.new
  end

  def cPost
    puts "-----------------#{params[:post][:msg]}----------------"
    puts "-----------------#{@user.id}----------------"
    @post = Post.new({msg: params[:post][:msg], user_id: @user.id})

    respond_to do |format|
      if @post.save
        format.html { redirect_to feed_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def logged_in
      if(session[:user_id])
        @user = User.find_by(id: session[:user_id])
        return true
      else
        redirect_to main_path, notice: "you did not login"
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:msg, :user_id)
    end
end
