class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def edit
  end

  def update
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end