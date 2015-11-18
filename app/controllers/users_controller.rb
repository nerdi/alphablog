class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end
  def edit
  end
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  def update
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
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if !logged_in? || current_user != @user
      flash[:danger] = "You can only edit or delete your own user account"
      redirect_to root_path
    end
  end
end
