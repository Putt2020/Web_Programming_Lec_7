class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :logged_in

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # post /createFeedLike/1 (post id)
  def createFeedLike
    @like = Like.new(user_id: @user.id, post_id: params[:postID])

    respond_to do |format|
      if @like.save
        format.html { redirect_to feed_path }
        #format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to feed_path }
        #format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # delete /deleteFeedLike/1 (like id)
  def deleteFeedLike
    @like = Like.find_by(id: params[:likeID])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to feed_path }
      format.json { head :no_content }
    end
  end

  # post /createProfLike/1/abc (post id = 1, profile user name = abc)
  def createProfLike
    @like = Like.new(user_id: @user.id, post_id: params[:postID])

    respond_to do |format|
      if @like.save
        format.html { redirect_to "/profile/#{params[:profName]}" }
        #format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_to "/profile/#{params[:profName]}" }
        #format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # delete /deleteProfLike/1/abc (like id = 1, profile user name = abc)
  def deleteProfLike
    @like = Like.find_by(id: params[:likeID])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to "/profile/#{params[:profName]}" }
      format.json { head :no_content }
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
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
    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
