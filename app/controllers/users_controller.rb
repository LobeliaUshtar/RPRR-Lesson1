class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hello and thank you for registering."
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "This user was updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "Successfully deleted user..."
  end

  private
    def user_params
      params.require(:user).permit!
    end

    def set_user
      @user = User.find_by slug: params[:id]
    end

    def require_same_user
      if logged_in? and (current_user == @user || current_user.admin?)
        render :edit
      else
        flash[:error] = "You're not allowed to do that."
        redirect_to user_path(@user)
      end
    end
  # private end
end