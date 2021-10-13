class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  #before_action :logged_in, except: %i[ main register ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    puts "--------------call show #{@user.id}-----------------"
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    session[:user_id] = @user.id
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    puts "--------------call delete #{@user.id}-----------------"
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #get
  def main
    session[:user_id] = nil
  end

  #post
  def pmain
    
    #logging = params[:commit]
    loginSuccess = false
    @user = User.find_by(email: params[:user][:email])
    puts "--------- #{params[:user][:email]} ------------------------------"
    if @user && @user.authenticate(params[:user][:password]) #@user -> check is it null
      loginSuccess = true
      session[:user_id] = @user.id # cookie
      redirect_to feed_path
    end
    if !loginSuccess && params[:commit] == "Login"
      redirect_to '/main', notice: "Either email or password is incorrect :)"
    end
  end

  #get
  def register
    @user = User.new
  end

  #post create user
  def regis
    @user = User.new({email: params[:user][:email], name: params[:user][:name], password: params[:user][:password]})
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to feed_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def logged_in
      if(session[:user_id])
        return true
      else
        redirect_to main_path, notice: "you did not login"
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :password)
    end
end
