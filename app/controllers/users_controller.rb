class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def show
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = "User was succesfully edited"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Welcome to the Aplha Blog #{@user.username}"
        redirect_to articles_path
      else
        render 'new'
      end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)

  end
end
