class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show edit update destroy ]
  before_action :logged_in

  # GET /follows or /follows.json
  def index
    @follows = Follow.all
  end

  # GET /follows/1 or /follows/1.json
  def show
  end

  # GET /follows/new
  def new
    @follow = Follow.new
  end

  # GET /follows/1/edit
  def edit
  end

  # POST /follows or /follows.json
  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
      if @follow.save
        format.html { redirect_to @follow, notice: "Follow was successfully created." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /follows/1 or /follows/1.json
  def update
    respond_to do |format|
      if @follow.update(follow_params)
        format.html { redirect_to @follow, notice: "Follow was successfully updated." }
        format.json { render :show, status: :ok, location: @follow }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1 or /follows/1.json
  def destroy
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to follows_url, notice: "Follow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #get
  def profile
    @name = params[:name]
    @uPro = User.find_by(name: params[:name])
    @isFollowing = false
    if Follow.find_by(follower_id: @user.id, followee_id: @uPro.id)
      @isFollowing = true
    end
  end

  #Post create follow 
  def Pprofile
    @uPro = User.find_by(name: params[:name])
    @follow = Follow.new({follower_id: @user.id, followee_id: @uPro.id})

    respond_to do |format|
      if @follow.save
        format.html { redirect_to feed_path, notice: "You just follow #{@uPro.name}." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  #Delete create follow
  def Dprofile
    @uPro = User.find_by(name: params[:name])
    @follow = Follow.find_by(follower_id: @user.id, followee_id: @uPro.id)
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to feed_path, notice: "You just unfollow #{@uPro.name}." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
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
    def follow_params
      params.require(:follow).permit(:follower_id, :followee_id)
    end
end
